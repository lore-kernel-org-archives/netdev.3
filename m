Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793066155;
	b=px1k1tpxkH9UYT+XtcUeimA6Fdbo8N34QooXAGtMQemC9M6CaaHoakUgCmG3+HA+RDLN
	 YPcOoTWgq9kHIHAHcaDwHQzj48bGK4bdkstPWyGblH7VEKIuZ19GbUYATLcIQ2O9LkhJW
	 QpoRiBNCRRMQL4FkWY1vsbkMRmYjLQwAAEmTaTC5IpUULe3hS/k5+tPoS6BTXl6kf/EuN
	 4avF30k6gYNUaQwVq+LH97iEg01OEnLL3f3rM8eOG4AGZHeTGFpatRNaB5vdETvgfLdri
	 hwGt0cCP0zXuBBpV/747NjJ/80feGftqeOeegELW+gX13lD/gcnRp9M5wkFJz1NCkiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=77IqWML7StqAN7sMwZCAci7s/VthwcJWiWQS34Pgze8=;
	b=2kncfL3DUbCz/s629jY2h2A6NJcWkEYRFoQnOeS2TXAKVzUpIBnUFreH3exRygoAjNFn
	 SzGexcUP3/PmN51Eu+sRCkSgc8W4Vxyh3Z2BggLJgcfcgrfJLFLiGTJmwS89+FezQ26kC
	 b/KqMKjZmokjv+BVi6i9f6jkasStmhsK5US9n0sJuNzndyDWLoW17Ox0dPWfOl4fNL8Xc
	 es9qPYio9ANf9Ywojk1zvmdZa+Ob0wue3cnF9ymHD7xlDf5IW30mXN1oU2iJsPswR3mwy
	 vuO2NAMGwVJXz4JH43gKNZY1zdyExfL/3InX9m+z2zBBSFQvIJtoBkhFGKfHdS7rJ3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LHa8hS7F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57543606A32A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57543606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LHa8hS7F
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso10673991eec.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793066154; cv=none;
        d=google.com; s=arc-20260327;
        b=Kl/f/m12gP+TzH+Z2t7IuqFaGJGUI7GtE24Y2cxMZ/URGsmFSGobL5dGTEjyMkJqxn
         uHrZe5jxRZdAvn0KAg2qdA+0//siR59kDAAF4HPscinXeaDAk0R9mBzV3Psru62NVdZ5
         UK6u6T3/W5QfSNVGW628Uma6k8YfrjdiXmGJrpQ9hr8Od8pdYUBHS+EBtxoxVMnSx/8q
         lqp7V413WnsJ9ko8bUW6NVVTaqMFBdfV9LsiZdMBlgRhQEY2jS+Jp8oTGozloJ3KE5mQ
         5ShsCIuIo9ETe3/T8eSJLHDuDG6Od9hDC5rUsZM1UDEF13byVZG7ntVVaw+sNKHncuXO
         0SJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=77IqWML7StqAN7sMwZCAci7s/VthwcJWiWQS34Pgze8=;
        fh=2bPfPPr5F4UDVF7IOIftSB6jfwJKUp38kft6/Qu4v2M=;
        b=SWgtKL6hfM9mFOrY3bgVpGB2Vt/K7C0pTPtfbhNW3WkcdzKc1l8dmp+rctSTwWzTa6
         v+X75mWCuq2YjatvO4TvkGyr563oaCd6yoQoKzu2rSlFw3Sg6eKbPFC+s4MyNpN7hicu
         ZUtgetD913MeYd7Fk9j0F76jxt8p5DjzICcaacnN/zA5dTq2DFGPyhwwaqhDf25wMsoL
         iD2+Wusa18HLASlP7WB9sQ3hOzxo7qNMjZNXDsgjYowR8nrx3kzVi0OKHc3HAoqF89e7
         IzS4d98vODA2V49fLHSLMFcL6NBvaENtFNzpX1dywlxijxMuP0MPqob3M8++w34al5e1
         RULA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793066154; x=1793670954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=77IqWML7StqAN7sMwZCAci7s/VthwcJWiWQS34Pgze8=;
        b=LHa8hS7FhhNkU98u/grVMm/uTgCw+bqUALtUlA45BnFz2iaxpAUe2FXAc4yqfZl3nr
         b1ZXwnLTKqlCB1mDSCtvDFhY6FsCnsgLEC9xV5hM+sC8Zz1ziP+MzIa2pW06xyH7UccQ
         QBTH92EGxG2SlB4kqXtLSS8SGmdw6gDQJ9t2XJDfFEqToxad3pCcesXYCnNV8dvw1Ci9
         TcFtUJzn/qLjIsBNrE9qQI/Sc7058K/jIafCOdPnr8dsIDq1Qblkt+Vnhk2tkj+0ZiS5
         NBII3QDgsGK9W5zIGFzaKEMVfbTHqAKEqkoTdKLCxHy8iOjkvgUet3Ec6THZJmFoMRLC
         /lZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793066154; x=1793670954;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=77IqWML7StqAN7sMwZCAci7s/VthwcJWiWQS34Pgze8=;
        b=CqylNWT/zeO+nboGnPyE/mqgXd4JkyyS/9IWqtI4JlY4Rw5vYf8SKVvbjigXJhXrHg
         8Kyt1cvGHsBfEqGbcub4uH6G5poF8eCtTP1kgzrDAQrkMAVcrOCGb1NoWf5GVDbMLrwv
         rHxvQZqZnnHxYt0SUl0pHErlHVOuJiv7Tz1qk9vz4+C1+C8Rv24rnsW1/Y+YUmVct1nD
         zacHY9Q6Ju/vdJLunRVmP2MHYkSNoScC+yCpSwP2ii6KET8qYeu3gcOQ7t/iE0rBSuZF
         gSWtvbU3Ze737+THnFiNPxRxoCPIxiTEekMfvS0jM/KAt+2KWK65BP5i7Bc37Wio64pk
         O83A==
X-Forwarded-Encrypted: i=1; AKwUvBwB7fmNW/xnoS8mSUWiDcMM4ugPSTXp30SkJUKS5hNP1rQ9fL1PpnJG/jpppUSg4HzrhCRDvPo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJp0p5t/5BEcmL7hT+FfJjwGgCBF0tOlf3Zem2aw9ke5lgSGi7i
	g1D6lRnve09/qd0CQZ61B2FLB5qNYr3Vh7QF1VDLRT4d4XxjzMnMdk2Gq8wTWkJUuuj1DzgKc0F
	OZan7E0IcDGKbP163wUO2NZsii4ziUNBOjaKNvXNj
X-Gm-Gg: AYBFou0+vxIF6LxC/7obHI7C3lBqATccQLnwMFlP7dUWr+/xIqPC5LH1mD0OVbj6Kmv
	xaUnW/04DGbSYqADDbuaRyUT5BYfLlOa8clUrBZqBndspD19JbZU8fauI1YvPXxes5/XDG2IeCH
	vwWJ6acZEWnp08CH3ZqmFHvcq8fV3gieq2DiYbxlhU5g3pM1TKNBG/R3ngZCFcJj8zddjbFGLJG
	7ZY1irS29HwRPWLqw5QGyaUP1ignUDWVR+r772PPCrt5tS+JwGyFXTivwsSPxcfQ2G2tV4WK3qm
	ZMD2xIk3YryAdz6sqSd9p14sWcSDsTp0pgjEq1hBSDPBiNxaHT++5R1Phk3uriMeOIPuhYnCzXs
	lRBxXxKn1bO99qhjHMQ2wBMEYnfpXdxifeNdUkWEKwjK5g4fnX4PElxeg7Uzol13xJbS9+rJ8p5
	/UwnrAyxz4ip35yLrXLKeMPWVgFsr5ZOr9J+LCGEoprsBHDe3gKfwZ3n8fSDGkRVWD0j0x3A==
X-Received: by 2002:a05:7022:ea44:b0:195:e4b9:d326 with SMTP id
 a92af1059eb24-1a1e405e0a0mr4384122c88.12.1793066153483; Mon, 26 Oct 2026
 18:55:53 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1685aeee-c65d-4a8f-9bfe-607e13e114a9@auth.ink>
 <2026-10-25-1-daily-reply-0005-af-unix-oob-skb-5-15-hold@kernel.org>
 <4ADFAF9F-7A76-4897-9374-914E5A384D8F@auth.ink> <A37FE39D-BD84-4FBE-A160-1ACE5AA98D39@auth.ink>
In-Reply-To: <A37FE39D-BD84-4FBE-A160-1ACE5AA98D39@auth.ink>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 26 Oct 2026 18:55:41 -0700
X-Gm-Features: AclHuK-9HmZC7VLxMmZYPyS43psLFDw64xQBE6-kn3D2u22OKCSPaUihqacBVnk
Message-ID: <CAAVpQUBA89A5qjL85pavgcYCpQ9jWFiiQXs9eBbHT+zAX1nC4Q@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] af_unix: Clear oob_skb in scan_inflight()
To: Tamir Awad <tamir@auth.ink>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, lee@kernel.org, 
	netdev@vger.kernel.org, Rodrigo Zaiden <rodrigo.zaiden@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 4:55=E2=80=AFPM Tamir Awad <tamir@auth.ink> wrote:
>
> Hi Sasha,
>
> My previous reply was rejected by the netdev mailing list due to HTML for=
matting, so I'm resending this in plain text.
>
> I've added Kuniyuki's updated address (kuniyu@google.com) to CC, as deliv=
ery to his previous Amazon address failed.
>
> Kuniyuki, could you please review the 5.15.y patch and provide an ACK if =
appropriate?
>
> Patch: https://lists.openwall.net/netdev/2026/10/23/274

The patch seems corrupted.

Could you send v2 ?

Side note, given 5.15.y will reach EOL this December, I'm wondering
if the patch might not make it to the last release ... ??


>
> Thanks,
> Tamir Awad
