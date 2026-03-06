Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB671AF4EF;
	Fri,  6 Mar 2026 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772829258; cv=none; b=Y8vwn9pQleBa4OViGca9Je8LrL+TPNZi+iNvyhfzmenrQrka05slAQEl5hBaTLDA6gn/32jmDeN7K8zcBnQMxSMN4KLL/Eu/3v8zJt57yzpoIJZ9GDuuoQYhnsARHETS5EqPYfVf2iKhhRVBDe8fY9yu+e7F4y5gpw284Xcihj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772829258; c=relaxed/simple;
	bh=8uuJpv9IrSLwbgcBfHYvoteNvJEBy5h846Xxdp3WJ4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jn+J2+MnyEArc29Br8ANrGmE9WwH9stYbyounSSjynopXEI8L4+ZhGOtZbkxWG3oSol90cBZJVRetOmNmGPJ93wwlj82USBGubmt1Pi8gSoK3XWbcest3WWmX0/0dXPWojPdTCOHCqQ85u6P1egLs0LWxUx0G39JOTDowWqWhqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow/pADm/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow/pADm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A7EC4CEF7;
	Fri,  6 Mar 2026 20:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772829258;
	bh=8uuJpv9IrSLwbgcBfHYvoteNvJEBy5h846Xxdp3WJ4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ow/pADm/hd7XnBEJxFQ4RbsI3GiNf/hV/1Q2S7Egj6dX2LZYMtLrXUP0ur/VqXNEQ
	 S4OX5bTHWfHsSrIYLxFnmh1kH81tZsiheovMduYVU7AkcXzty42hSMkAhr7syvylij
	 UMhybVmvrSi6DLPbdeRChjLLYw6bvcJqvNaAnyNQRfaeaNuBgOD1wyW75tMjO0dX2Y
	 AHHO785Uz+P+dPOBcSw1WX00jic/vQucAFGEp8sr0FsWD5eJEWc/BgnXxX/2V57sgS
	 NBHuO6cuXs8cxsseKjP5WXiJbuGVFaRUK/sO1Q3j8ZikosjhHXWcH2yqNrWTgVixMf
	 1JUcroythMCvA==
Date: Fri, 6 Mar 2026 12:34:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, willemb@google.com, daniel.zahka@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com,
 kiran.kella@broadcom.com, sachin.suman@broadcom.com
Subject: Re: [net-next 1/3] psp: Support resetting statistics on a device
Message-ID: <20260306123416.33cc12e5@kernel.org>
In-Reply-To: <CANQF7iCc_t43FHa+fysnZ=vB9DibvkV5n7v10OXkbZ-Ogsyt2Q@mail.gmail.com>
References: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
	<20260302195352.1015990-2-akhilesh.samineni@broadcom.com>
	<willemdebruijn.kernel.270f71617ce0@gmail.com>
	<CANQF7iAYmKUj_WeDgf4dg941Zxm5bBVzz=yvX17PmyKMOYe6ng@mail.gmail.com>
	<20260305065915.1e6e3284@kernel.org>
	<CANQF7iCc_t43FHa+fysnZ=vB9DibvkV5n7v10OXkbZ-Ogsyt2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Mar 2026 21:24:01 +0530 Akhilesh Samineni wrote:
> That said, if the common practice in netdev is to avoid providing
> explicit reset functionality for such statistics, we are fine with
> aligning with that convention and not introducing a deviation.

We generally support resetting the whole device or its specific
"blocks". Can't think of any reset specifically for stats.
