Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB028F5
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789895058; cv=pass; b=D0399hW8lSxnDmY12f/2TegIxA2yKxndWQT/MLO4WoLXtdkr6obIlE0En/E7VTpM4tseuub724zABg9N7UthpYw6V/+wofoRzKFP5pSDkPOPIxOjyuRNfi/CvW6X809f80ih6rTifQdd7q9a10kbSCEk8HwvHpImJmDLVq1BFG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789895058; c=relaxed/simple;
	bh=7h7iCtawWBW6zeTXUkzWrN3kEodFol+KDSp3ePBJEV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Az/dkEeir34wATg1HHtN9efar8SezjGMRoelLy2fk09Rw7pNPhn9q+2vxUsyRw4JQFtqdJd7X1//TEE2L0mh+ubcmI/9kYWPgkdFMkpHkhfEJsRibHmeKdBFL12pzGQA/mKrHkXvtD2WNYd7x13nkVzx3t1CdPlqzEJB6UxVxpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr; spf=pass smtp.mailfrom=khu.ac.kr; dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b=MibyOmlW; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b="MibyOmlW"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff148dfdso13269801fa.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 02:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789895053; cv=none;
        d=google.com; s=arc-20260327;
        b=bGNiNscOZihRIVxYFyxOTtwxGVfTmJKxspV7zeNTmY5nP0dW6iN7/L2cWTULtN7T0S
         X/NYBzJW666ME2/tcsrHtcI0WABAoIhF3AZSFJ45ojUMvJLH0o2TVsbC/c34oxS52xh+
         Yov64x+a7cY1VIp5L9YYPesuJB2PVHzd+2nGvwsllU2D8Z6k/aqCwaWoyNw/MTo3EEPZ
         ruTb6Etd037Nsramcs56IxaOLqcAqvxSiYg8Jkv7QqWus7VLQbZy0kKZBDhWgAga64uk
         hgDS6Q057Isf1WaN7WR1Qvam59Sfs7tPuInupSgeV9DggMLAgmWsB8GnzozN+E1bXBB5
         8TTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7h7iCtawWBW6zeTXUkzWrN3kEodFol+KDSp3ePBJEV8=;
        fh=v/VeZS+3DYKPd3dHNrpUSNASriqlOkegjRGddTe8epY=;
        b=gy8SAK3hn357ZJ+6Gi/PmoCUSvxFzaT3MykhGWSlxDMW3Y9inKuwFQcmhjJHVvv/hb
         lPOH9WToqkTap6nhkhOl7dJq4T+NydrXsiIZaiilO3jhACft7rZu9vQRVGG6eLOG2n1t
         0K7F45ppgxRz5mMKteWLRHZdsgWFMfcxaJsY4OGAf3AeFj29HM8eH9g+E/rI2DoTdTl3
         nNcf2+ARokBUJxf9bAr/+e40qWrh/vZPNo21Ow81rhINdMCDtynTZaC/SKOE6xAAI3iw
         bUrxIVOooI5J/BxLviiIHpQi63ZDvG3zJgc4y7zGGkzDscKNj7ny+9zupWsSauoyRou1
         9rOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khu.ac.kr; s=google; t=1789895053; x=1790499853; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7h7iCtawWBW6zeTXUkzWrN3kEodFol+KDSp3ePBJEV8=;
        b=MibyOmlWKcMM4R37MV0Pv+wS9ERkOK6+NkFUyiXCE73xLHzEqFJBxC4ui/nDGytElB
         G3LXD9Y7hGXOmV9u2h8j85vqJHRiGhT0vgUGvMWGqUoMTrvRbvWUWYC/6nxb8QTZpEf3
         u+YIsZxZjzMqFgohsv6qbz64V4L0dSKcel9x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789895053; x=1790499853;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7h7iCtawWBW6zeTXUkzWrN3kEodFol+KDSp3ePBJEV8=;
        b=YAqVvBBb+xGkegaKfJU731pJhCyMLTe1UbVKjbomUSqDXCbULtZNiULigKEj4dacaQ
         RsOXkvt2EL42QsZpgAYv4r4OTwizdfTZs60BsAhxYUkiMTPDyXhOL78APE2LdRJMYHSC
         tyeaaD2oVybbVe5KsX+PK7OCE6LWidAxlKkgUm0LVfP6RSpaTZkrmwdC7xfggMW+NgLX
         kyFyEjajkLaj3qBHJDkVI+rn8K9ipdxhERzLm+Gs6STaaZoO1A3DvwFFyTVKMsUNWtZT
         vm1th7is49FBkhPbd4Jm2MgpOcy8So7gygSZq37ulHJQZ0heNvlz1uVejsFSQb5m+wKO
         sRKg==
X-Gm-Message-State: AFuF++ljq9Nu+tjvqLVd3kJQ9lXKc2mVIAEH3GavOtKyLH6eA6S8UsHk
	x56AKyBbtjsH624h9YNuOavl/n5dQV5u5L78YlJhU6VF5IZSpOWm6Qjp7Q2a/Am6iNwszutOqKY
	S9/JMhqbY19oahFyDOOTpXlMflOcBYWSXMo19jkyw5YZ5ttssMx19WOaESA==
X-Gm-Gg: AYBFou0g2Zc5uY4zgh76ITAEi8jmml1P+dAgSJjM3Fp/Qzo5dzW+dLF4AsTtFUUoOLZ
	08wh2jv15egWD3jWu7BoRJV8xITnU7ZDCSE2ZZDocGx48bBnnOHdKnVEXhuIcLKlFNDC5qRHAfG
	eK2GsWyiruqVMXWhRWPSXagbsF5lpmb/+LqY7QCU2YZM0mVodO8Q8j4IT/vuz6ocheevRNhsHQn
	J+j5aubL2A8uzNkhi3NHVQ4OLLaLBchYgc48Qs8O5jsMzkq6TEcmTz+rZLyATCfsLLTtg0GrMWT
	nnkLPUT+ceQRwljvsYFmHYdSJatGEu+xmRApmnW2/bPgbZvN26CUoSK88wm6zPGjn7M/425Wr6Q
	Qyh2NUSuMnZjORP1A9DwKtunLvr337fjxMw==
X-Received: by 2002:a2e:a809:0:b0:3a5:da9c:4661 with SMTP id
 38308e7fff4ca-3a5fc0ba103mr16356161fa.26.1789895053440; Sun, 20 Sep 2026
 02:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178911388614.25348.8892025153904636456.macb-resend-1@khu.ac.kr>
 <20260915083839.71546-1-pabeni@redhat.com> <CAH1Bc_yQYJ6cWyYVvfWK0pAgrXW1TMkpzmNxZvAXAKZJdiOqWQ@mail.gmail.com>
In-Reply-To: <CAH1Bc_yQYJ6cWyYVvfWK0pAgrXW1TMkpzmNxZvAXAKZJdiOqWQ@mail.gmail.com>
From: =?UTF-8?B?4oCN6rmA7Jqw7ISdW+2VmeyDnV0o7KCE7J6Q7KCV67O064yA7ZWZIOyghOyekOqzte2VmeqzvA==?=
	=?UTF-8?B?KQ==?= <5mghybrid@khu.ac.kr>
Date: Sun, 20 Sep 2026 18:04:01 +0900
X-Gm-Features: AcwNN1VSKLzUoUYJ6GcIBhVxrZfglX6N1QXd5KkfLl4b4ZnArqwwx8LlaDHcB7M
Message-ID: <CAH1Bc_z6PFc7N6XVZ2dQEH=7D9mkXwGkXP2KKMW-Emd4zcf3fA@mail.gmail.com>
Subject: Re: [PATCH net RESEND 1/2] net: macb: Preserve one-step mode on
 rejected timestamp requests
To: netdev@vger.kernel.org, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Paolo Abeni <pabeni@redhat.com>, conor.dooley@microchip.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	richardcochran@gmail.com, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

Following up on my September 15 reply. I noticed that the series is
still marked "Changes Requested" in Patchwork.

This series fixes rejected timestamp requests changing the TX mode and
the two PTPv1 RX filters disabling receive timestamping. As explained in
my reply, the additional issues predate this series and are not made
worse by it. I propose keeping those fixes separate so that this series
remains focused on the two reported bugs.

Could you please reconsider the Changes Requested status in light of
that reply and continue reviewing the series as posted?

Thanks,
Wooseok
