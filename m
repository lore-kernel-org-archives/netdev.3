Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0C395ACF
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812699; cv=none; b=jq1Q6jZn+ErCJS0K8phtevuc7jRfnQW1v8IkZaZ9C7EKJMuwV/U37pwZ2iyZ5I7l3zEWrC2DMs0v+KcgBtFNsdP4Wx2/SsCAwdLT8WcNadEc/7I6Uue4spIE+ijuXovxUyzo/+tXGJdagb5Eq48KfbmAbJ7SMxkTq1b4BbZPm5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812699; c=relaxed/simple;
	bh=oSkTDAAzn04o7bEaWOCaoupEriQumY6yq5NDH62Wu6I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LaUXnNGsr2eukScxs4xE5tirvGi0K/kVgZ7JI98GlOmBelClcAcrKThwdVEILUuFStrGhzE+3MstAADZ8NbaPG3crzyQgwoB6mYIo5AGS0Sgk9RGuIKGp8UOpY/WkdQIlNQ+fFXR1N72nq9+6KcRskJnjJF9poHT6wqTgwBZWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St8PMMpP; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St8PMMpP"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8114a4542b2so60931817b3.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785812696; x=1786417496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HUlwf4K4FmOZKVZvEIHJGfsyTp9ZANuX8LKy5jCQlRk=;
        b=St8PMMpPZVNaKMdoZchq9sISerwSIVmR0oxSh8rtf1dQLNkgCIxFyUtXRqCnZbBHkU
         SRNoghnDS6gZ5w0aYAOGwJ8/A1m6A1usoUXtwDnth9GibtvF1/b/SeIuCOKNxznfS2mt
         3Cz7/yi79zyBdiqL36QEJUV1vLvaRHCda/5hIkkIf0jSJmDY2JS8c/7fs+uyyJZ5rRZp
         RwGWBakEPw2hFEf7UzZpOKbJkjuaJxyWPG7KNIqARbIhUKnNRWnB2cz9lVGu4yW9wOMG
         +dh8jIoFOdnDN2/iF/Fq2gS/fz21qyKE3rRDUMTJlM+74N0rEfPEF77rLOV3FZQ3E5Rf
         cyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785812696; x=1786417496;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HUlwf4K4FmOZKVZvEIHJGfsyTp9ZANuX8LKy5jCQlRk=;
        b=ONizOh+xnzPtr0pjTWKPxkRa39AOj6yRPdjkX+OIOYkC4iEd5AK/bEERrMcY0DCIpc
         5Tx0wSKuLO42ts1f5VqK9LKjbqx+se7PFeibPyeZdAkorhlPuqNNxXvkDvnf1oZ456Z/
         VvkuQBUbaqXQGkzkui+rae/agSSL1NDoRE0eKq+DJ4/LA6A3Cft5ZP3pAzZXzhB32oVY
         SICCfmjRXmYtfJnCt9Inlz6OLGMz6Dmr2g9cWPiO3SCv1keCFQuKXLr+glMERN9vmqkb
         bSnNwYXDB1CDhMD5vY2JLlXjJQ42EdbSUxXCTCSnm67uiTuFXAPdjQ+7nr45kVWvPYBB
         0Xbg==
X-Forwarded-Encrypted: i=1; AHgh+RrJFKZgMvH8uLuTqE4HeJpZpIlBrzEZhCkPh1fZxgyvrm4lYmBnoTXAcam6s28sWvoMnLSFHzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1LFHT8LzhHy1yW2ktYcTQVTUTiqQAsF3At6Z3GSLUpBlPo1Yu
	ykINPVOVWBZ+dBTcJQmJCgaxpUE1zvcViSznm5HGZSnQUNaoszi8ZM67
X-Gm-Gg: AR+sD13D5tYO8eBwvJ+KH0kRtpGQVe0eMyfF9SOUMdbfogyGYpN5sjLmN04vvlSYkrg
	29VH7d88Sy1XON28Nkk35CyiYRru/pLLKsLyd96DyKtAv9rXhisbVT1Kp2r7yy0aKwsNaZ4zIvo
	AzdR03VuHUQSw41wZ5u2ZJB5CiLp1RkE+FPChDlnUEkmOIsENbQrX3bnU3X10ULayEDzR9fQ3tj
	OxrGfyTnISnJwig2fQ4+czMovaAD1oiZX2xlKTIiXCpiiu0hTo7FKMs6q2e4/qBjcY9Eu4NtpPi
	qpfBpGyXGoSPfBhhusMUJVrZHWI3Gx6lEC5fZZrOUpFDgC+yEYe+nTsyzXGnWA6y6B/hbL+rk2o
	2NC0mgAilEg70srcS77HGd0Acn1fs5K/kVX6Q8Ruf8+b1qf6wWX7Gb+5GOnWlyzxhVKNZiRPED0
	isCkFHQ63wctoouPrVFHwni649sDE1Q3RScQgbpdxYsFJEF0tPVDXlP9neWkgGo2Pul97D8eNSp
	CHgxUhOmsC6WCZvuJ0lmIiznQafXk6w1tC2
X-Received: by 2002:a05:690c:a9a:b0:80b:9114:3b7e with SMTP id 00721157ae682-81fd4a2d85amr160196937b3.12.1785812695758;
        Mon, 03 Aug 2026 20:04:55 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82006078e91sm13105417b3.41.2026.08.03.20.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:04:54 -0700 (PDT)
Date: Mon, 03 Aug 2026 23:04:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Qihang <q.h.hack.winter@gmail.com>, 
 netdev@vger.kernel.org, 
 daniel.zahka@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.ad7f187edf35@gmail.com>
In-Reply-To: <20260803192228.49a49867@kernel.org>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
 <20260730082925.93759-3-q.h.hack.winter@gmail.com>
 <willemdebruijn.kernel.f39af6152c60@gmail.com>
 <20260803192228.49a49867@kernel.org>
Subject: Re: [PATCH net v5 2/2] packet: use consistent hard_header_len in
 TX_RING send path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 30 Jul 2026 05:22:21 -0400 Willem de Bruijn wrote:
> > Qihang wrote:
> > > tpacket_snd() reads dev->hard_header_len independently for skb
> > > allocation and header construction in tpacket_fill_skb(). Concurrent
> > > netdevice reconfiguration can therefore make the reserved headroom
> > > smaller than the amount later pushed, or make copylen - hard_header_len
> > > negative.
> > > 
> > > Snapshot hard_header_len once before processing ring frames and use it
> > > for the frame limit, headroom allocation, copy length, and skb
> > > construction. Pass the snapshot to tpacket_fill_skb().
> > > 
> > > The separate SOCK_DGRAM consistency problem between hard_header_len and
> > > header_ops->create is not addressed here.
> > > 
> > > Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Qihang <q.h.hack.winter@gmail.com>  

I missed this before, but Qihang is that your full name?

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

> > 
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Willem, does the *shiko feedback look like false positives?
> Both instances seem to provide different feedback, if I'm reading my own
> tea leaves right Claude discarded the Gemini feedback about a panic
> as a hallucination..
> 
> https://sashiko.dev/#/patchset/20260730082925.93759-2-q.h.hack.winter@gmail.com
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260730082925.93759-2-q.h.hack.winter@gmail.com

If I read Gemini feedback correctly, all reports are about the current
solution falling short of fixing the instance of this race condition
with dev_hard_header(), which reads dev->hard_header_len directly.
The patch indeed mentions this limitation.

As well as the same issue with dev_validate_header(), which the commit
does not list as limitation. But that one is only reached with variable
length L2 protocols.

Side note, in net-next I can probably remove header_ops.validate now
that ax25 is gone, and with that all of dev_validate_header. No other
variable length L2 protocol ever implemented that callback.

But that won't help older kernels, of course. I think it's fine to
remove that CAP_SYS_RAWIO branch in the fix, which never had much
value anyway. It was there to allow testing purposely bad input or so.


