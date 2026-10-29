Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793236278;
	b=3WJRk7h7GKULDzdb9pPpndjxHbvOW2DhxXTzWFFPYP+IZ1aP1qIk1jCAFxk5mF9i2CW2
	 zjiIrFvaM47MW7w2akfWjHSgRhSSsGrFzmFY5U6vsxXJL6n+RV+6nKoFiqhZCSR3OAVyc
	 BMRp6RrbkwhW+SKWD9r3csAWfzWgwxEO7Afl4N93FLhhn8xW/LT87zDjhHcvtplUO0jzJ
	 DVXLk1NHln2fFTeCR9jhl/Py5fDamXshp+2hwSFCa7LCHpUmFn574ZLDc1G2arPlYzl/v
	 V1qDEwcsVHu74GYbcC0LCTfoEvpeM0+cMir1tHPQfArmyNMYfeVa4RkaBk5IMiRg4NQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=T8vrlnjARGiDjuRUwRWUbox4bHtSHamjWdpm50A3jNE=;
	b=lv+9Xdwhl4t2vxugs6Jvqs3UGpBfeQGeYddm1XMzNQCnyEG7hgluNLZHQmNPQFyflLuF
	 Ma8Z5lEuwh5tXa/4mS1NCWln37keyf9k/3pT7gf9B8qcWxYGuX3IF7/XyOTvyJIYxeTm8
	 EkJVaxJy8TLU75d30zajC/2NqsJd1063ant4vkkX1zqX9+wdkDT15dAkUo9+blhSd8ann
	 Aa2SKr/P3IJF9FBNUNbGVudYa6nyfgwhKMdGFOy233eWVV1r+KpAneT6VQrjFM1RyOri5
	 Bge44oqPwdCHDL0lZpCxDcahMWdInvL3kCW9SEVkEBZTcikxBN3XoaIkoOS/dTxEJaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=QFn0RApB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA96606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 01:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCA96606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=QFn0RApB
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-886e61fa30fso791289b3a.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 18:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793236277; cv=none;
        d=google.com; s=arc-20260327;
        b=l94k8/+56+IlKUnCe881urkdURed5SgTKKdIPn/CqtOAQWdHNXBwzoC1voWq+7zUlK
         Nm78v9nslDFTr0FSfhA0EbPvuRXOzFvGduWIam9a0NlUZMlfGsKuLK3j+/nJuK42AkYE
         KskWLBWDZB1hFOJ1SdsVDV9zXTJOTHlheSwecCMqa1ZFSW2rhTNRIpOoJ0dzUlrPhmm/
         H0V6BYWM/Ijr7TiKtFsbQxgfsAyObbfk8nVexi+BCOrgUagg2UymaxNFkupifci19BHj
         n0p9JorOzqXlAb9pJKhZ7BzxP1t8JQvXLuHDWOwkPVVqEmMZKBb18jX/TBp+TjN0SvoE
         leIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T8vrlnjARGiDjuRUwRWUbox4bHtSHamjWdpm50A3jNE=;
        fh=hN+Y/wIkw7vLXNUUzap0GdKQQlEs7yQPeojl4/ZQBLQ=;
        b=asrmwdXLfqC8ORRnRi5ZmmhZNEA7+BKh+sj9B2WOuB7kjHdxGc3gHDtCp9YuZJlhFp
         h/mE2ps2TT5i5GrcSPzo8T5WLu73q7Yfwu4yIOmtbdJB/uXsYNybm+JMfBsTdMpqF0NB
         c7dXNF51CaUfmvfQ9sxsx7QeGxI4IETty/Pt30i+UnZql68/Pzi+LuF9y2ftnmpBSbTD
         yiZPOo8JyMpTdo3BFV0LTdU4sthGCoQVGL6PHB+7bGunRyU0PPBIO4bi0eluAN+nKZeA
         /lMU/rKZ4LucEaIdl+f+W2GenWOSbkoro5WnfvHDD2XSGWn67t348TlhNeOoouwPbnR1
         Rr0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793236277; x=1793841077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T8vrlnjARGiDjuRUwRWUbox4bHtSHamjWdpm50A3jNE=;
        b=QFn0RApB/826lxN0LU222f/R+lapxjGz6ks3phdhGPowHtq/z2VmroSMeLTTjb9EjF
         uiadR4Ik7VcZRxFCYn2EQNJ8kh2xOz3dmVXvF4UgI+PvdXKLCJVV7DJYXvrI+mG3Ow/G
         BkxiRET922nuV0OfGkx5WEoAMh9EK41xLUPv5t4mmeQlRB/Hj/L8vOB7FdjwYm+/+Rz1
         ZbQ3uAhOJY7fB/2SKI2fMP3FcNTXJBq9IdkoPcFaK1V8gqkiU3FUmJRsuCCbikMI106R
         6ObyxD4tX6zTYoGj6f91vcHj4HAa6T9//0PQFNMmg+Y3tp+USNTf4Roeeyx7pzi3V0F/
         DaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236277; x=1793841077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8vrlnjARGiDjuRUwRWUbox4bHtSHamjWdpm50A3jNE=;
        b=2OUSsBwsbJkdyaSciI/cyTdb+keRrmcWDDUu6Hst9vbt9e8uqMBI/nm/9DDzPukbug
         Pl2qwFrL4Vt/1cWUQWNnr3DMVyZ0vC6+KWI5FhhkC8vM6j+mvDiAjXPl7ZL4tBLLr6Fo
         WFJ+B2ImKTAAxOZ25TJ9EIG2ucIneHyvSKKYGVSzSl70aAqQ4ES58q1gIYyVSsmldHTn
         k/V/glTAf7F8vnrMVeslcRK3GlAgXG9Xr2/p8nBvQ/p7UrQRyYXUnQZnpFcPtXs5rUiz
         9v6btmL3DlrzN+lTEKBfy64ScCnOkZ3ZD3ijeGUbmi94C6jC29lpIdWwOI5Jz9N5H40z
         mS8w==
X-Gm-Message-State: AFq9FYL8lMbFdn8KwZMkynPmzlejsDxcV3zPgkt5uLr8f8t3xmaCvV6l
	00Z4I+6SiuCNlUCrTJbpBMgm943KNauiudHRQkMQjW0PqQBZUwoIovp4dAOoej2omgf7Pl2wtLP
	Y/FFkyUGl3Za9mFGiLms89SedrbvsxQ50glTbw0xRAmgTRgPtr21l/jNJ
X-Gm-Gg: AYBFou2qwds9lqw2O08sdIHHw7tK0FLF4BlEr02JN1U1bmKnVUV1woNKyPi41W1IExD
	Ii/fggHPPYTuaVceWn9Z3R0ggvZFOvPX4SdIIliKO88PZpXcl8tE82PNvKQCFBhAy8Ct3pi9LP0
	8AJXsWbB1IFXBirqV+r0piBBsztLVS8xttKsum8rA4yjMKFkp2NL2lA8sHAN7o1tu8B6JxTQwZs
	g+aA0loLwX/AHXZQxXj9NYzJ7gYJA5aCuO7ayyMVoO8aG/Nor+d//WC1YlSjo2F0ZTDzhIfv3F6
	wyqiEIdwG2EDEghi58/7GYqjSjw1iOBLpMRuFIWfFX9jkxm7xmQpBuZlUKz5VW35ev+Sfbf4LM2
	Dzr6OVk+IupqZ+WrakTt8MktOI+v8PCrq9mG6uvWzoEfkmr5Ha+Mgm8GbcSuHvVLY6W8B
X-Received: by 2002:a05:6a21:3e0a:b0:3e0:e9f7:814c with SMTP id
 adf61e73a8af0-3e9023833fbmr2058685637.33.1793236277145; Wed, 28 Oct 2026
 18:11:17 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <uOcTaW7-g5e97ng6BG_DcH5mlMnpw7KzU25SZjL69pkAVINTMiL26FryLAuYPSNowDo8qwfb9hm_I4dQ1BwpiRe62E-I2TyUkJZ_eBeuLoo=@proton.me>
In-Reply-To: <uOcTaW7-g5e97ng6BG_DcH5mlMnpw7KzU25SZjL69pkAVINTMiL26FryLAuYPSNowDo8qwfb9hm_I4dQ1BwpiRe62E-I2TyUkJZ_eBeuLoo=@proton.me>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 28 Oct 2026 21:11:04 -0400
X-Gm-Features: AclHuK_-Tt6aAk1Q9UVaRNEoFiyF4HEXUF2NG9jMAfN6nnbuCUnaax6L8izesW8
Message-ID: <CAHC9VhSNfn1=Ln3NcMC1BzW4AQiZuDvTm+H5rkY1aKc-RcKHpw@mail.gmail.com>
Subject: Re: [PATCH net v2] cipso_v4: fail the walk on malformed options
To: omniameasunt@proton.me
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Qihang <q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:16=E2=80=AFAM <omniameasunt@proton.me> wrote:
>
> cipso_v4_get_actual_opt_len() walks a compacted IP option buffer with no
> validation of the option it is standing on: it reads data[iter + 1]
> without checking that the length byte is inside the buffer, it accepts a
> zero length byte (spinning forever), and it never clamps the walked
> offset to len, so the returned length can exceed the 40-byte MAX_IPOPTLEN
> bound that every caller assumes.
>
> After cipso_v4_delopt() memmove-compacts a socket's options, the bytes
> past the compacted region are stale and attacker-controlled via
> setsockopt(IP_OPTIONS).  An unprivileged user (CAP_NET_RAW in a user
> namespace, CIPSO labeling configured) can trigger the walk with
> connect(AF_UNSPEC), which reaches cipso_v4_sock_delattr() through the
> SELinux NetLabel hook.  The poisoned optlen is later used in
> do_ip_getsockopt(), where it causes
>
>   * an out-of-bounds read of the adjacent heap object copied back to
>     userspace (kernel pointer disclosure, KASLR defeat), and
>   * a stack buffer overflow when optlen exceeds the 60-byte scratch
>     buffer (return-address overwrite; exploitable for privilege
>     escalation on kernels built without stack protector).
>
> The same helper is also called from cipso_v4_skbuff_delattr() when a
> label is removed from output or forwarded packets; the option bytes there
> have already been validated by ip_options_compile(), so the new checks
> are defensive for that caller.
>
> Fix the defects by making the walk fail with -EINVAL as soon as an
> option header is truncated or malformed (length byte missing, zero, or
> one) or an option would run past len.  cipso_v4_delopt() then drops the
> socket's entire option set (reusing the existing branch that frees the
> ip_options_rcu when CIPSO was the only option), and
> cipso_v4_skbuff_delattr() leaves a malformed packet unchanged instead
> of rewriting its header based on untrustworthy bytes.
>
> Well-formed option streams are unaffected: a socket whose options
> survive the compaction intact keeps them; only malformed streams now
> lose all options instead of carrying a partially parsed set.
>
> The function also compacted the option object in place while the
> ip_options_rcu remained published.  Lockless readers such as
> getsockopt(IP_OPTIONS), UDP sendmsg(), raw sendmsg(), and ping sendmsg()
> copy the object under rcu_read_lock(), so they can observe a mixture of
> old and new offsets or option bytes.  Build the compacted object in a
> replacement ip_options_rcu, modify only the replacement, publish it with
> rcu_assign_pointer(), and retire the old object with kfree_rcu().  If the
> replacement cannot be allocated, leave the old object untouched and
> return -ENOMEM.
>
> Fixes: 014ab19a69c3 ("selinux: Set socket NetLabel based on connection en=
dpoint")
> Signed-off-by: Lucas Dupr=C3=A9--Rabinovici <omniameasunt@proton.me>
> ---
> Previous version:
> https://lore.kernel.org/netdev/CBLsHx48w8Bn1k_Xg6kJFliLNkxLCqi8SnkifapxYY=
pVtll4w-W_2JJePtbk9ssIS701IFJvi0Q2n5l-2GFFe8hNHU9Y_CgD_sdzcAbILVA=3D@proton=
.me/

Hi Lucas,

Thanks again for your help with this.

Qihang (added to the CC line) independently reported, and has been
working on a fix for some of the issues Sashiko identified in your
first patchset.  I expect that Qihang will be posting their patch
publicly very soon, perhaps you can take a look once it is posted?  I
suspect that basing your patch on top of Qihang's patch may simplify
some things.

--=20
paul-moore.com
