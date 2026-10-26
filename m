Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793026068;
	b=4T+qr9/DKLRAx99+GogiOmvYFdAKcJg56y+P5SeF+meANTn/MUo08ATuTgssNKyNVtOp
	 EzxIsZ+z5e2YKi6jU3q5DcOAKk5htNYeWLtlxlTrmm+QE/nFg/5Oi+U2Nl3utV5zGY3F7
	 3PqDS6jwGay14dTIZpbjDO4BzNsQp3AxzTYL07CPZKJkTo8rphHo9+zU/9PbjMVlgdz3u
	 zu2PgKIADTn5/FABsAN8PAjVxJriOdiCvI/JIyURMIqa+IwJAUhdp7BuCBr1jRkQlMXbX
	 jyg3Eo4DMm3htVNDd3RKzryZ10euuKn4nhNLNm/HgKZxopOe9IJE0aEeYgr4IEzKvmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QKdQFJ+FO6S53u4bEibR73jMpDgxkOnbF5dGbreuSCU=;
	b=P0WI0oe/Q3s6PcMqFjWP4QJ6yth0NUF6pN9ymnXbkOB9Ee8jnQ3RO/6wvXjzlEhH2BPy
	 iHuI95/Q4nfOoda3BVTHxeqtYUt3dDKMOQAX3Md23E+24aZU4x4bnELpu4NULBCkCQmvW
	 vVfSdfwyY17aQHNrcJfnxdKOjHyDka0x91nfZ4E5S8Lra0mPsfQA+YGJ1Emy84ryKnB3D
	 BFBaQvwB5Ptjq3vlT4DRu3PnWUFdDiibLvJAsgLk907yKiRM//VeM81oXuy5JU4+eRkld
	 pF24RBRJa5xF9pPanlXvv5MaxHp66tTVGR8ga590QFb0mLr2BU3+a2VbibHPQ3nYLBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lb56rzpI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3C8606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E3C8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lb56rzpI
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a058315c79so1157706b3a.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793026068; cv=none;
        d=google.com; s=arc-20260327;
        b=Dq5YALx407W6RKr7EdCp48oMzjewVBfV7LFquW4jl4oALIfWmSdo9rpbXTOrgzODnP
         ggbawtzX1+KzggPIrRFPvFbVWQ1YCRKHbdgGSRW4sN54KSmWkIvrYywx8wa4/Vi356DK
         OHcnLkJ6y85rVLADFDj+B9MMqY2MTVqW91MI1ZYyj6mGwQlFt2eEdpuEjQPZO+e3y6U6
         mE0ACYCdnuePDXCFmJh3MU6l+R3IPWLWz0RUOlERq7t//36C9YQrV0twNXkGnzii4Sxl
         yfu1Wfj4Fr2eVuqbxJpZLRmfktC0MxZN4qLOasI6U32Y/1Eb1YU6BVZcMymOzEhY0+kU
         VxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QKdQFJ+FO6S53u4bEibR73jMpDgxkOnbF5dGbreuSCU=;
        fh=VlZy2f4d+PF4Wmki2DeWXhGGpNvuyttoZj75Bt3FWTo=;
        b=Ke1VVpSzvVZu0ajrA2nNHYOfDNjWdbn3bb38Fk3NRh1recDlfS8fYrSpam3//bUucK
         8MMmFiP7UGAac0QJN+AaPWk4ams/tg+9HEjv/yunnENZhxgGYva/ddRUr20tuMuvSHq0
         CU3KMOZX3Iem8E0QSv+uf5tD4HXIZEQdZI1cbwyQd0CkmFs6HdxS0+aFsoF02NaEDbYI
         3EUbBs6BFPtjCqyeMqL7e174FgP58BgPTHGD/7FqW4giIyczKer9kSqcjf19ef0wlwsV
         LF7wyAlBAs7ceID1q4LQLr41ywDmzDVBPdrEjvS3+n5S/cxX1yV0/ATAFkncWruy3Mvy
         cP0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793026068; x=1793630868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QKdQFJ+FO6S53u4bEibR73jMpDgxkOnbF5dGbreuSCU=;
        b=lb56rzpIO1LxCDOU6SRaulK6a8nZmTn+nU5EVvwm3gZfwrveORS5n/PPE4qQbiRClu
         zgNtnm+OBarJydQrUmHhg1V6GMFxe8n3hYR2/dTYNyMO8ZgZmtUtSe780y4h5mtLYO55
         JGkYj3UtRTyzblawo222Fiq/wK3QioUUsMUHC748TeAOUOuhpox1YpddQDIZs6AGZ8HJ
         uKG+Ek0jo9GVErMeorxbWp7FKdjLIQ4iz9G3Uzqc+EqnKH2DJS6x0vFSWx+Gs47lMARA
         pllTlPWJmAViqJZO0abKhJW3nWGX+dkYsOQJKMfERjwehF8tMBgd/esRVP5N3eJWr4DJ
         zhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793026068; x=1793630868;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKdQFJ+FO6S53u4bEibR73jMpDgxkOnbF5dGbreuSCU=;
        b=DxphPsyREJwKRV7NMhP01sM+AOP5vHnAujF2QYCd2twzjxRQDu/nz/+Yddj6pPo6F0
         0wxaGlFHrc7HYoxzaFkGosHePBIMxDps6JcZ9cdnFK2ZBri+idWYKquqRfUsGIcmTV0e
         cYzqOdgcMpoSCVGtWlad2kbm8KZB7rmsqmcQi9adGje13iyTzUvsjRRA5b6YFfIl8TJu
         H82PZQwhi+Z/PlbJfIheJD1kWZgGiq0ogBLF0Hz5xUYhxHWeF1e0dwQNibhu0AkO52OQ
         0iQTWEjoDNC8Fqn9h4i4KSxmzR349IWldWjXZ/GyICpOzUnXgGdRrPvMBx6rd0dpQzXc
         NqTg==
X-Forwarded-Encrypted: i=1; AKwUvBxFxbfhjWIUgYvAlmsoQRKldpCOAZJ/Q/BZRwwHs96bHdU1XeDbEHihqYjPishS4LkhCxtzjic=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqdulszsQqWeyFCGXw7F4BGBxbR2BNAQsYd9x1aZhqTU7Ynni5
	57Xlo4tAAoHW4KsiPzqsOYZ8s3uLS/YhLYGEFg7E6KcKK0zhMdFX34G6ISB2cyuIegF05wJsN7t
	tUqoTwG89qiBCIu+pYTCjlNzW0Z+0uNE=
X-Gm-Gg: AYBFou05zjxKRfK8PFLYBKdRhziEGdmeDs7wpr3qk8GGQIjpAIJsaaRDBacjMdgucd8
	XZFkvmXIoQH4dfUtfypJgyYtQS19DvP36A/89EeEmIJtw0kTx+IvDMZTAjA1nYwmb32iP6V3Jfk
	Y9ugr+lsrQrSMfu3C3/luN0RC9djSCQ2336+4snsuf8wiAaEbNppwtY/OLW/ZoLylVSl1fWb5EQ
	AaNjmRkSITi/r8dLf+DCNyFXzGuu6KIZW7mQeuXK1gxWwUqNTVkckyl2A1oPgBRfGll5oaKqVtQ
	Ywt26VfGPAWmyVqCSt1QkowX7+M6MzXB8wGhDUdsiPM5rM3Vmr6N/jVSUGIyaUm7InviIK71/Nu
	EMrvI4ZdggJMPcy/tpqFcG7t1dZkxtPCxXNynCTwUSiJu8AMsagvwWJqtVtn2gGXqCoGdoeTw05
	CTx2tQPY8GCdKuvzjjPNyNl6QC7Kv6KkEws68H216+dYVwyfiqdEAtS0Cv2w==
X-Received: by 2002:a05:6a21:1bc4:b0:3e0:f6be:1988 with SMTP id
 adf61e73a8af0-3e7cd4d6324mr5359941637.73.1793026067638; Mon, 26 Oct 2026
 07:47:47 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAO-4RZ1ZCPNR2Z4xoHDh0Vp3SO51oX7ojuH0CG4MsD14-RegcA@mail.gmail.com>
 <CADvbK_e+ogH4zafpqz8N=jY-oBruke8OLd4PEz9xa-y13Ys_3g@mail.gmail.com> <CAO-4RZ3_m4BN-+dkGdteAGdUwRHd4SA2pfAD+_+6z+iH+btrHg@mail.gmail.com>
In-Reply-To: <CAO-4RZ3_m4BN-+dkGdteAGdUwRHd4SA2pfAD+_+6z+iH+btrHg@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 26 Oct 2026 10:47:35 -0400
X-Gm-Features: AclHuK-IERqiBgrQvteRGbBqttOJKFiUd95YICzl26fPZNFkD0zcsHfchiXbLiE
Message-ID: <CADvbK_c5HG5hY-RE_YHRyCvUnTLy4taWRGC1PW6OT2rQ7pBocw@mail.gmail.com>
Subject: Re: [BUG] SCTP: KASAN use-after-free in sctp_unpack_cookie with
 fail_skb_realloc (7.3.0)
To: =?UTF-8?B?6ZOu?= <fengaojigui88@gmail.com>
Cc: marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the test.

net-next is closed now, i will prepare a patch for this once it's open.

Thanks.

On Sun, Oct 25, 2026 at 6:56=E2=80=AFAM =E9=93=AE <fengaojigui88@gmail.com>=
 wrote:
>
> Hi Marcelo and Xin,
>
> Thanks for the analysis; that matches what we observe.
>
> We reverted 62b08083ec3d by hand on top of 7.3.0 (the surrounding code ha=
s
> changed since 2006, so we dropped the goto nomem error checks). The three
> sites are sctp_sf_do_5_1D_ce(), sctp_sf_beat_8_3() and
> sctp_sf_do_5_2_4_dupcook(), replacing the pskb_pull()+goto nomem with
> skb_pull():
>
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -751,9 +751,8 @@
>   */
>   chunk->subh.cookie_hdr =3D
>   (struct sctp_signed_cookie *)chunk->skb->data;
> - if (!pskb_pull(chunk->skb, ntohs(chunk->chunk_hdr->length) -
> - sizeof(struct sctp_chunkhdr)))
> - goto nomem;
> + skb_pull(chunk->skb, ntohs(chunk->chunk_hdr->length) -
> + sizeof(struct sctp_chunkhdr));
>
>   /* 5.1 D) Upon reception of the COOKIE ECHO chunk, Endpoint
>   * "Z" will reply with a COOKIE ACK chunk after building a TCB
> @@ -1211,8 +1210,7 @@
>   return sctp_sf_violation_paramlen(net, ep, asoc, type, arg,
>    param_hdr, commands);
>
> - if (!pskb_pull(chunk->skb, paylen))
> - goto nomem;
> + skb_pull(chunk->skb, paylen);
>
>   reply =3D sctp_make_heartbeat_ack(asoc, chunk, param_hdr, paylen);
>   if (!reply)
> @@ -2253,9 +2251,8 @@
>   * are in good shape.
>   */
>   chunk->subh.cookie_hdr =3D (struct sctp_signed_cookie *)chunk->skb->dat=
a;
> - if (!pskb_pull(chunk->skb, ntohs(chunk->chunk_hdr->length) -
> - sizeof(struct sctp_chunkhdr)))
> - goto nomem;
> + skb_pull(chunk->skb, ntohs(chunk->chunk_hdr->length) -
> + sizeof(struct sctp_chunkhdr));
>
>   /* In RFC 2960 5.2.4 3, if both Verification Tags in the State Cookie
>   * of a duplicate COOKIE ECHO match the Verification Tags of the
>
> We rebuilt 7.3.0 with the same configuration (7.3.0-kernsight-kasan #2,
> gcc 11.4.0 Ubuntu 22.04, KASAN/KCOV, CONFIG_FAIL_SKB_REALLOC=3Dy) and re-=
ran the
> same 42-program sequence that triggered the UAF on the unmodified 7.3.0.
>
> Results:
> - Unmodified 7.3.0: the previously recorded run triggered the UAF
>   (1/1), with the first report at t=3D212.7 s.
> - 7.3.0 with the manual revert: both runs completed without panic
>   (2/2), and neither serial log contains the KASAN UAF report.
>
> The same input sequence and fail_nth annotations were used. However,
> removing these pskb_pull() calls changes the fault-injection sequence:
> the reverted runs logged failslab injections instead of the original
> fail_skb_realloc injection. Therefore, these results show that the
> original reproducer no longer triggers the reported UAF after the
> revert; they do not establish equivalent injection coverage.
>
> As you noted, this issue requires CONFIG_FAIL_SKB_REALLOC; our tests enab=
le it.
>
> The revert patch, the two serial/console logs and the syz-execprog output=
s are
> in the repository:
>   https://github.com/Zheng-zheng-codes/sctp-unpack-cookie-repro
>   (see revert-test/)
>
> I can also test the other two paths (5.1D COOKIE_ECHO / HEARTBEAT) or 7.1=
.3 if
> useful.
>
> Best regards,
> Zheng Zheng
