Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8628B7EA;
	Sat,  7 Mar 2026 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772851224; cv=none; b=N+xSLWYUXpaN5hFRp4SeApfG2IhPxP/w9XehYhCWSKwrS8sEvHaj93dXMiqjtR6vSQ7VWW6SsqA2hCjxqYPRnHYNNBd1JptsVbQSNy2h/byIplif7kCl3xjtdps5ljU5S+CNENY+pKeoQ+zMmqBjv8lcy0sxCjcZreUFH+K3D4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772851224; c=relaxed/simple;
	bh=HZQFAAyDDXALJ0Xqu8BbCyAgfDExWhr5LaSvxymIhHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWx+y+o3lSKIyanmdnVj0dsAnU1fGrHS7jMO5wd9RGltVF6JZcRAubIUeIF5fAjnwtosz8FrHKoXKlJk19wYGLwnb9lP7+vVvWe3OtS3snJDKR+tsTyX1Nc/VEqadUADlG/LeIE3UO5Gbki4WQmDm9i2ArXRLOaYyvyGlzpml1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRzVqAde; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRzVqAde"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9414C4CEF7;
	Sat,  7 Mar 2026 02:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772851224;
	bh=HZQFAAyDDXALJ0Xqu8BbCyAgfDExWhr5LaSvxymIhHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bRzVqAdeUNIY0nr3BCApVnGpmLRJajeTRfPKSMk2UV17jn2p8IzNnPer7mGrXwUTk
	 VCUU8JSKUfjqW5p846RgXuVV6P9d++OywrnJSNLt7Ee4EfnFmlEjTzjNf8fRYFr1yb
	 o942cnW3th49kPanV30LZgV3u4sQITgTo43zwH4YNkVeG/PLLdsbGPBiuBjfxLSgKt
	 RIAIFH5IkeLuwWO06RnYJg3KQUJrPqgbXchi/ZKqyfhXDqEYdWXIWRjvaLkQOirNWB
	 4Ge2W5r4Z0SKDczwdv/EGTYS04gPOeh/kuKc3LOjjGEzkITg6ed9GX+V2/QoQeddeh
	 CQRZ/PufT9a1A==
Date: Fri, 6 Mar 2026 18:40:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jialu Xu <xujialu@vimux.org>,
 brgl@kernel.org, kees@kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Remove <linux/of_gpio.h>
Message-ID: <20260306184023.208897b4@kernel.org>
In-Reply-To: <CAD++jLmaUn=usx-N4pMSK_X6GobSXP00T34rhpT7U9LPOzhKFw@mail.gmail.com>
References: <7187C401290C256B+20260304084808.440955-1-xujialu@vimux.org>
	<D5F95320CE72E20A+20260306035539.2443355-2-xujialu@vimux.org>
	<CAD++jL=sj=DCuRvOveVeUo1RWmS9ZvA6YqXNjOQf3qhvyRzL+A@mail.gmail.com>
	<3f88caa5-cf81-4734-84c1-ae3db15c557a@kernel.org>
	<CAD++jLmaUn=usx-N4pMSK_X6GobSXP00T34rhpT7U9LPOzhKFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Mar 2026 14:27:59 +0100 Linus Walleij wrote:
> > > The NFC subsystem is orphaned, so I suggest Bartosz simply
> > > merge this to the GPIO tree at his earliest convenicence.  
> >
> > This should be sent same way it was before it got orphaned - nothing
> > changed in this regard, I just don't do reviews - via net-next.  
> 
> Fair enough, either this or the network maintainer can give an
> ACK to take it into the GPIO tree.
> 
> Jakub, what do you prefer?

The whole thing seems to apply on 7.0-rc1 so let's do that and both
trees can pull the hashes in? I can cook up appropriate state in
net-next or Bartosz can.. no preference in that regard.

It looks like the code may still need some love tho
