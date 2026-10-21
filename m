Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792590719;
	b=ClOMG3Et1QzMmIkVDmwaFNVbMD6N6pTA8IWHEwi+6RnxpxxoAHmJzTMlb30tBddUZ3PO
	 ES2nUq7jjWSkRnC59pi8yF3eLuv4+Cb1S5kzSEramGHNda/lCMOKWHYYYjDVeL5S8/P9J
	 5tytCYCep4rwm2WOHwTtc8Si3NQD9oUU7GPU1M6JDxWRdEJrgzT32WiJjDTwc7+wstRFq
	 Lsh4IajwkixDf8xiHBFbmPJB6kTOB8pKJwyGe899B3Oo3q4kbunkV7Tq9CkauarFmVUDH
	 s3USBSza5WP25cA+IKYrf1dc3W04lvWnkzzyDHCdFTgkNcrSpNq+WzRaxgjSxtbawGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5afhtd3cTwW6HTlFrbfLSEsRMBvqB11pORiv38t1qGs=;
	b=TVTrm9+ZHztUI2z7ECr25l/3i/G79MwKud2FczQisSuEB2fUZQ7xcEKgFKExK1WwD+Wr
	 5EGUZLm5A6rzBElr5pod91jZHw1ICNc2ki+WuUmn9XDP1RtxoOS1ZA0aQyBCxKiH1f24j
	 aDFEUXHp5aub65+92JHSfAUqFGs3G1meTk4o/7gvhKIugHJz3znd+6hpW0UirjMVQmq6F
	 El8tOrVgVcc9iZJEe9FPOoDF77r9NxqLqJQa+kcC34xaH98uECfu4qYdxzXmGCzy31rnO
	 mEYoENgjizBS202Aw0/xaHDEUa2s2auIECq5I/2Nd1PMUXwjtIyy0Ita+FEQcBS9Fig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=plzFiKZE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46632606A328
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46632606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=plzFiKZE
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f259cdc86so73035885a.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792590718; cv=none;
        d=google.com; s=arc-20260327;
        b=gS6djuoUDiUhkLAQ7+H5d6ppa+Ybh39bYbdiwz3sZtqcl3i2DMJ9r4HsbQRskCa7aM
         4BWTsNSCfFL5GQrY7Khi/+dz9cB5u1kel0kiTRuIlz4XYLshRDJkisApXpoKqMZMftHv
         pftoCKGDYpP02kM4xr2y5/IpwJjx2Eq7C+dLSymQ6Cv5q/c7XyiFOPY79/AJiMR8vTkL
         deoewgRJO+EfmRw6IEjTe/PkrW8uOUD7P1GW+7vCDtzzk11ryk9K2WaT8KxH1uekabPr
         3vXLmyGqpdU3qKisyLRJOac7MXxTsX4vbnHT/KknJiS0stT4q5oSFkyj1UhCoa1Wz23h
         Povg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5afhtd3cTwW6HTlFrbfLSEsRMBvqB11pORiv38t1qGs=;
        fh=BWJP/AWCI842CH77GpEJDd5VmIYedjLQ1kceelvDf0s=;
        b=n8RVFjO9tkVHNPBeK16xU6L8Y7T5ZXB6hcKMjKir9i04vfeNtKexrXPO2LdQwoIAb+
         KUs/LMccRhJRObwWKX9gMQcKH3hFK+9bwEJIZPwTdUbkUpWYDUydRxhVwp0IMRTFRwXa
         iWGd7W0E0Ribn85B1v+PqvwDf3clPaxX/x+iI03ufmWGYyOZA/kcYqCLHT/0uT4YIGr+
         Iks1bQPCkRkJzHE++3WxylK9QoS0JkZ1SpkuR2YfVrpFv02s0eQ7mbGFpkUIZUVoKbVG
         eItQSkRcBwwrdnJhMnob2QXmKdrofFarzQazG2F/M9JQcbN9tA+D0GaUCGfVs19pUee4
         5gdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792590718; x=1793195518; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5afhtd3cTwW6HTlFrbfLSEsRMBvqB11pORiv38t1qGs=;
        b=plzFiKZEAk/A6gGdDujp2MG45A4vmRkax+a6cu6RGVsfF+zV/yScg//6ECFikkLMmC
         0X6fSAtlIUJR+I/GP/ibGlM0eBQvH1e3+UCEUQVmSGICgls/DW9L6ogTZOnbEzvzEtLo
         7x1zHWNC8q8xNzzG+2hIeaeRHDenx32okWqWeJ92LCcqvXYZzwNZF9AC5t+hRW/CtMkF
         Ien7XL6Vgh21Sl3pB8NUHyg33gB/nGs+SJlm18DBbm6+sqVOhL6d7MjpnMegHqnOCqM9
         +Q7Noh2p8m0GNLEcQ05vzWJPASESxUVwWjl6hsWXGHZ8SVpl1WBFkzHG7C6sO7EM4Bn1
         xXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590718; x=1793195518;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5afhtd3cTwW6HTlFrbfLSEsRMBvqB11pORiv38t1qGs=;
        b=S4J3ZFHX8VHbAC6fH0DSf9hthjrTdrUSKNdnY4Vhp8L1Ih29lw59sutQWlnT/1ajcQ
         3/hAykmfHUQ+nmT6Pa1ZKpk5eFnw7iH2/tqiD/nKg7vmDJguGjXjOwudMf69aPY0cnOO
         aZYFrzxQTVa3YgrXBcoCRkBcD0Komea7nIS/cLTdnT/bloK+OE+mo04wQWAXYHYd/79/
         DIJSOUbnvLUw4bbDhMCKeOSJBEayjHUjNWY4V8UNdYRGvLKACrAuA5V/zYrMntNU5YeE
         c0KGvncA/jc3uJBaCSJITChxVKtHwwwMNGbQ2+B9vn8nyEGGUskuVjNiv9TVi7T4d+ww
         scpg==
X-Forwarded-Encrypted: i=1; AKwUvBz1i30+YCfU+f/wWAQc6SiV779ddQAQu1YpXaMEJZIV4gyD36rfVvvW+JynJ5v9X/kWHlEAIsY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcW2SLtz+Shstmk4y9gsiF0w4cH9R/X67ckp1wsgW5QLtVUSI7
	A2veGnwMXI6vPNSbNLfXjECYRWYvX2jHqEUbqddhlRZgGaaJvAxl3WZQAR//vqklJDv52eRLDDH
	cFnHwWGGFxMoEygGgwvfe6mgwSZ5aZrg=
X-Gm-Gg: AYBFou0v5YzTA5PGEJgwkqVE8K3WMy5A9FZVplXroZZ1C1wF9u9RshiNS/wxbeVBO97
	TZG5VeVkbnxeP23Swhnp0PqXKlHCLA3OUuhk3u/+VAZ3X2pMaPIjbJ5Ah95GzS59ZS5WFfCq3Qc
	7Q9puXZ/AdSMebX+TFtM7OW25Pg9iHZUXmqYV0gpJ1E8b/0sunCVjrc7qPTpHtbAg+27B8K3eyn
	FYUxEGW75uTC4Inb/lf5m/v2tgjgCVrseJAsjbzl/SY3SRMVRYDRNcsMobZNUO5Ay/ZyU4laUyo
	EhagxjprHMntorGuVm5vvnE8PAK9+3UvQfAqbINckClyp8830weVs12JZ41eQ0TlMvRrlINP8tK
	d4MlL7sq/xD7KCdENIB+/fYnHWBtHuTuQ/Me+zDxjRvpz+PiFigEURcFNDW/Ki8eW7zhad+jrum
	ZNvLvqsMc+PHXczabN7ryVnkmigF3wzf9tyTw6UK+DYW4A/No3Zjg33N1WV3TpDI5pNUavK34KG
	UIUo4Xu4IDdk+t0tCa9TBUfrmoghKBB4n1SJ2hJkdG2yNRW8xARYirxbiXZkfoQMT6bIeWbARnZ
	yVoAB9fX7Og=
X-Received: by 2002:a05:620a:a8d4:20b0:93f:5f83:2cbb with SMTP id
 af79cd13be357-93f5f832ec8mr63850485a.7.1792590717833; Wed, 21 Oct 2026
 06:51:57 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012132622.48550-1-jain.sm@gmail.com> <179181183946.2527009.5855837780305581870@kernel.org>
 <CA+FWx=mA0dsOSopCNBiA_8BrYSDYD7=jxMO7uLpxT1OOU-BkWw@mail.gmail.com> <20261019191351.0719a13c@kernel.org>
In-Reply-To: <20261019191351.0719a13c@kernel.org>
From: shashank Jain <jain.sm@gmail.com>
Date: Wed, 21 Oct 2026 19:21:45 +0530
X-Gm-Features: AclHuK_tJGQGHQXYH1HoqC8CgY_oDtEKoqd8_Z2JQ46FXa4s9FQglS1oEe75ov0
Message-ID: <CA+FWx==JYSLqPChB9QprBeRnxiVM0cu5cxPLhrwJNi3Afitgaw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/2] tcp: keep the route window metric when
 SO_RCVBUF is set before connect
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, I read it, and I understand it: the missing information should go in
a reply, not a repost, and if the series needs another revision for other
reasons, it belongs in the commit messages. v3 was posted because the fix
itself changed (the AI review of v2 found that the socket-state check
missed the TCP_SYN_SENT paths), but I left the "how it was found / how it
was tested" part only in my reply to the bot and not in the changelog.
That was my mistake. v4 will have it in the commit message of patch 1.

> Looks like AI reviewer has some comments that need addressing.

Yes. The v3 review found that the SYN cookie paths (cookie_v4_check() and
cookie_v6_check()) still use the old rule, so the window scale of the
cookie SYN-ACK and of the child can disagree; that a single bit can leave
window_clamp below the requested value when SO_RCVBUF is raised later; and
that the bit is read on the listener without READ_ONCE(). I will fix those,
add the listener / SYN-ACK and cookie cases to the selftests, and post v4
as a new thread with a link to v3.

Thanks,
Shashank

On Tue, Oct 20, 2026 at 7:43=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 12 Oct 2026 19:04:27 +0530 shashank Jain wrote:
> > > Please do not repost the series just to address the above. Instead,
> > > reply to this email with the missing information, so that reviewers
> > > can take it into account. If the series needs another revision for
> > > other reasons, please include the information in the commit messages
> > > then.
>
> Could you please confirm that you read and understood this paragraph.
>
> Looks like AI reviewer has some comments that need addressing.
> --
> pw-bot: cr
