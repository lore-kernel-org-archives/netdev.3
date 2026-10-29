Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793273441;
	b=Ugxl7CG3TBpBx7dR9xodL2ew4sZMAu83PFlezdncUXHtsSrMfVTUVo1molqJb3u6mztC
	 BHXWcyfQh4CyLZ+8lHvXW+Zd5JoqgbotLjgartYBFxw2kkP6rYyM+8AUZ/ScBXguJbmxs
	 yERfBndu9zYMXRS/7cki9cKjXPjnBUxVRp14d1QFHUE/uwAFg11mOwo1zPDse1wp6QJOx
	 bP18yWtYpjL3YUamtcOinFEu9aWy1BRJc+K38XPnHgGETKIRaD0Utsb6zuruzdvURZHuL
	 iwa81MeiH70rNfIQLpG4AqxY/oXi/TNtRcHD536Wchg1g3GLqOeLFBPpScQFPdVJE+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273441;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=br7XFFJlnTE2nrlAwCzRO32OAfBB0UYKLO1cFSCtOzGIVgobMT6djdhUQxFnnuOEvj8a
	 7EZekp8gziJeFME20qAyWy0jil1oyHvx5b+MD+ytjN2WwC4OkIjfPNckW6hSRaA9WXMDu
	 QKxJEikEaLOWU700CKuOkimj9438TLJylSgWAREW7XOLFTH7Gr17swS5/YsP0vIy6FZ7c
	 Y+Y9lJvq96p9DBChwM8gWnLXADFk2cLBfUkbcA+6ibw0Y0xMhl59hYKrteK4e5MnFYVt+
	 FnAs9/Bgc6oPF4MNE12T11rQ8q7yfAsl17foybhE4v4Z0mUQR8HGlXuRCuAr/pHwoEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JapGeHju;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C89606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JapGeHju
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C401F01825;
	Thu, 29 Oct 2026 11:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793273441;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JapGeHjuCeLmMh1u61zh82H1NYLBP5J/IgUf37ggd6h4yt9v6xXHQ6z84hmeRBAJn
	 AMno3uxGrBgqwrbp4fmdfRAjEAiiZCZ3ULvT5XjyPiUliROAjpM++BA7IVbMPd2fiQ
	 PaxLwjOE6SK8LfKgP8/Wp924opbKYw7gJrXSXbssgXK2SHxbz5j2DBhJ9WAOd6Zeqd
	 MPchI4mqVEaeSVz6rXgXWSo1a5MNGGq8Szt3Kcn2ZlJUyzdalS7bUA9uXUDp/9AGEI
	 NeyL4fBJxjTxiqrWQzPsAYRHsHFcJyCREIKyL171avTw0UtNEaygtwnnUi3oMgWe2D
	 BcewhSN4BDoXg==
From: netdev-bot+sinfo@kernel.org
To: memoriaru@foxmail.com
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, johan@kernel.org, kuba@kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net v3 1/2] net: dsa: mxl862xx: bound FDB dump walk with a
 read limit
Date: Thu, 29 Oct 2026 11:30:40 +0000
Message-ID: <179327344028.3327.14084939226295973095@kernel.org>
In-Reply-To: <tencent_1AD6B5B7C296D319F828A281A2A65B95D609@qq.com>
References: <tencent_6030CC520C02054D1B2925AEEF6FA92DC30A@qq.com>
 <20261029112528.56652-1-memoriaru@foxmail.com>
 <tencent_1AD6B5B7C296D319F828A281A2A65B95D609@qq.com>
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
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
