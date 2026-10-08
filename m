Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C33A641D;
	Thu,  8 Oct 2026 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477820; cv=none; b=tb+r/vOzwjm85um7AJ/qX/wjiKSpcZGcGtKz00D4fKjonEWEoceW9mhs9zEhpByft/u7WrW0LT79P5LXRGpvf1UBxrg+Yya0Q6oSUVrUwXSijODL+I5mfQDT6xECivOuUJvg1DDhkjOUxwwgapk8JanelXNPBZozG/Yfqf9b5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477820; c=relaxed/simple;
	bh=lgLpwuWgVKKuShTi6MStnn4VxPJcgyRS/LPKBh9Skrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUcmvE3Fc7UzqY1/uob7sAc8hJ/YG5YxXrl37toAPrfkjSEYZQY3/5XEhSI5GPRA28h3VKRwv9Eaf63FK30ChxVEAz7BIw/z4OM0eFWBQfU/2++JYKMJp4YCwBz0kvQJ8+xsgNDbJd2+S96eYL3/yONlcwlIcg2TUlEQk81blJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrFprpBM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrFprpBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52F01F000FF;
	Thu,  8 Oct 2026 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791477819;
	bh=SXzIkCeQHUiL6jrkZftPyMDqQ078Av8kyUPhluO/X44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KrFprpBM/IdKMN/BuYZ/Cqgzom42DyuXrtmtmrx8FUBpO9WIel0cETuvzks7uP4SJ
	 nOefCxOxDFRige3Sm6uSpyCPYCBQwI5lzRJPk/STYlMFlU6i5tXVX0ZJg4qbWkTE5c
	 +GqENUrv9ndJbC3FBSr807AVJRYRYkKTwxS7Vuan+oXKvWHeU1p3O83g4SzfytPjnj
	 Pi9sWqOnHxArbqJpzuG58QvBpbtUS0NEQqGT3MRYlbtVY0L5mFT+ok7eRc/WmhkbLi
	 R4DgRTehdYmewsJ4OX78ea63FrmeVchjPhc/eGgwJvjTDRwCq/JqN5pPEfa2advwb0
	 z4v1Jzm5Ow8lg==
Date: Thu, 8 Oct 2026 09:43:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: =?UTF-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>,
 oneukum@suse.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, david.laight.linux@gmail.com,
 syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: Re: [PATCH net v6] usbnet: fix smp_processor_id() use in
 preemptible context
Message-ID: <20261008094338.301a75fa@kernel.org>
In-Reply-To: <7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
References: <20261004215937.302247-1-omermetekaya0@gmail.com>
	<20261007200049.079aeb75@kernel.org>
	<7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Oct 2026 10:16:02 -0400 Alan Stern wrote:
> > This looks odd, how did we miss this for 8 years.
> > 
> > Greg is probably busy, but would be good to get a confirmation
> > from either him or some other USB expert that the callbacks
> > can indeed be called in process context.  
> 
> They can be called in BH context with interrupts enabled.  Is that close 
> enough?

BH should be fine on !RT. The patch, AFAIU, is because vhci calls
the completion callbacks in pure, unadulterated process context.
I'm trying to figure out how urgent the fix is, basically.
If it's a vhci bug then the usbnet fix is at most an RT problem.
Also if vhci is doing something wrong we don't want a truckload
of slop patches sent our way to fix 300 drivers :S
