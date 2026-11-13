Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570451;
	b=lcjt5tkfi42tj71u5zl4e+tntIduqEiCXAvMkMUbxl/CMYT6/aInMhwchJIZY/LeX77y
	 lN7+ta7AWQ26+VMRQdGAekgXUNbFoPNhGGuNa9Q0RJiGdLJp2CXux/l6LzlbIfWVMY/GM
	 +L1AiEHKyTNz3go4OwC5ZgUkLW5OFV6xhnI+Bdb98m3lwML/Zdhew/OxVq593gBlLa4MU
	 Gurb0YsuKhJ2/Oqoz5vN2uIBtnEfdNQhT6K+zS+ZFYFOWeoB8+rwMje270Lkuq01pkpvF
	 /M6HEnT3cRIjC8NMBVeVRFzHsvGA+II25J5v/B7j0CFhhev8mrP5TWIqN8SNzHQlTVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570451;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QRKjoaIFdZcdNI6xhQFS3ddkteDcVtqc9gdnFl/fkT8=;
	b=ygItnJmGsZ7rQBskE27z2T91IOEtJhBQ0tiy8sLdyIV7pDlwT5vPzIHtVZ9Q3VfWuQG1
	 Sql9bp/bGQw1mMvKySJaRhgwytTwCl1nCQiLXm96qQzT8Hr6jd5P4PM2ZusjeeCu8TXql
	 Lf08T+P8tGi6E3/FqnrfnvJfThxf0fAMxbh2ue8IiRhkwsHd4P5plAtPXGKcMBQBw9Geh
	 nnpcw7IzfO027D0ZQMU6AF857xtY03ZIjFRr4cF27D0jxj64IdU3bsZ2IaITn76toU3v/
	 WUl43jl1kgYNeFNLLWMxjixjC94iBChdJJdo6tz8cHVe1eH5cRkVDrYenKddXxaz7Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELviE2qh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E5606A333;
	Fri, 13 Nov 2026 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELviE2qh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C3E1F000C4;
	Fri, 13 Nov 2026 11:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794570450;
	bh=QRKjoaIFdZcdNI6xhQFS3ddkteDcVtqc9gdnFl/fkT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ELviE2qhjHKkgD7NBAi295Va5GnITUxC5rM/CetbA9/lc6h4Xl32j7t1F65j4uzUf
	 C+mpzF9848sWd9EwDQ/LPFTT4biPOKLxmKgsg+ABasx66tUUaMe1CEn8S9r+7RqPcH
	 YCGQhMcViMCz1gR+TyesYhxplyLR9BOkD602l02N6pzIvYY2GLvaDwe1e7DKMTRegf
	 nj15n8UJn6Y3EhCUZbAMd/y1K9rlXCWxA+s7KK72dHv9GYMEqqAeW2clqWpMhhv2Sv
	 TOCktHbmUynvB5U+fAntaw/5z/5yn54RrKJ/UL7kKwGlA0J/+aE4KemAyBtzOjPhod
	 lrpklC+/uvkEQ==
From: netdev-bot+sinfo@kernel.org
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net-next] net: sparx5: check DT port reg against array size
Date: Fri, 13 Nov 2026 11:47:29 +0000
Message-ID: <179457044999.2168702.11721926329454503825@kernel.org>
In-Reply-To: <179457014579.23820.10657909253312598784@gmail.com>
References: <179457014579.23820.10657909253312598784@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
