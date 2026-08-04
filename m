Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA2325726
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855709; cv=pass; b=KbkpWjxZXWRFf1ja5TfNwItJAoT2i4/rE5C5/5spYMgnt7Q4bn8e7PzwE7z/ueNsWbi6PUYcSvb+jz28oP/X4EfDTiGEmW0xCwjkB1hQjWbA4ngMv2vYcMIDX+YDdpO//wkcgZ0v4AV782rl8OTg9o7u9WumZSzxJm3AHwG5HJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855709; c=relaxed/simple;
	bh=Gm1Bg0Q4DelxFOLvPjQd5M/mGETysFMssmFfnQE9aUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyoAnCIkgHnAcrPLDgyUIPY+Vnnml2JAcCExSSMdTGOqXxyvluuuMH0u/3W+UQe+2frHBfIc3ck8UezAkptZXSPveXHSFiDEwJNKYkgrH/x299C/lBt3xmbWE3K11eZQ+ocoY9LvpZn0JsFoojVgyQnutpjjD9rciOAzypm01vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uU/qFRsJ; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uU/qFRsJ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51a868b6962so46341211cf.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 08:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785855706; cv=none;
        d=google.com; s=arc-20260327;
        b=hzQUO5oCraFlM0iJW9m9fB4wQXaZUzPbzf9h3ofIWPWPWCEc7hvgJRePFBT+E0P+NF
         JsYiqKS1sl7UvqzyHQ6cskIi386kmd8DS3ISD6EKE/hvhGTzd35C/uL4nl9AT2wq0HbJ
         CtBCagkBlSeSDY167japzDRNDkqYWRfQGEYdHv1IK6RTgvTzkyeoMubrkU4KAlgT5iTD
         gB6zl3a6NtKY04qtWrqKlwWZgbNpmGMRipIOb4WQet5PcuE9c4e6NnbYIyMHWma8rCZS
         2eewy0UejVEQ7Vy2bmQ00QEah8v1xg87enDMChqbp6l/GnS0DW1PsRtwypkgWUHvju4B
         zukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gm1Bg0Q4DelxFOLvPjQd5M/mGETysFMssmFfnQE9aUs=;
        fh=GLBfsTPW6JrX3quexW1jY7DRAHM1eb5CtCMduAb7o0c=;
        b=LM6oNyvXWNnlsymOCOha7apbKNNjSdXA2brrKfUVBApbIcw6fxTtpUWOd2Jv2+47jB
         Zm90TMr4XWKTORRPyEiW7U9IkVAOa6SFZzfFJ70h5L1h5I57gaUajXHEPhNCRxd5slKF
         RrodxVCvwm5KSoFWd7eCObaOVE4qHppHIFynFxQrlLEIwPIFt6jsRXiOPikH01PQAhai
         hVx2aHXLeiub+thLBG34u40Rtubqclig/SNMDoUDZADerqNnJUG/2y/8o4hSsPMv0k/w
         MP24qM7WlinhM3vyuNPqRLAAmav7Wn038mlmG+TURfgChpzPS/mwhGCYeNFdRIwQe2kZ
         /ekQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785855706; x=1786460506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gm1Bg0Q4DelxFOLvPjQd5M/mGETysFMssmFfnQE9aUs=;
        b=uU/qFRsJRsyz2D+U0sh47u5KIJ0ZhmJBZOF9Ex+pwc1syF0qCT+iXeLlGVHJnuAl6a
         Q/EchurVRhkASrHTVFB6NY9iAuE04EPwS922kmyv/ZU2pu06Dk2BfdccimIVPisR7TMw
         FQvhDsxUXlRxmHzUzRP6dI4KvHTu1PHokLjtqkyIw8PmoYWYnqRQyQ0Jn8GFD0D1i6A5
         jyGn9pluOKuE97jwpozcLOapvKTjVz+ZM5LQx1E0W6WYODwfd+Dju+/CY172xHJynZMz
         F8hg80Azv+D3CteevmBjDO6zaPu2j6A26ZToAgHWU1E9zgiuuwPr2htyXbHej8NGO2kl
         42Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855706; x=1786460506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gm1Bg0Q4DelxFOLvPjQd5M/mGETysFMssmFfnQE9aUs=;
        b=s3V62nky0cem5UbTl95rDqZhfwDcZ25bgN6JJwaAg2PiqSOqM9MbvksAXpJ2Zx2Zq5
         tMJb5p5FkBVApvo6N8hkVyxJyeA5C5+mAqtjXi0k+2JXYG7PeC0J9S3crDOhP/ARSCwQ
         wLX5IriAtuytkbLKecvcKjfPRbDclMOUBMXjgJPZnKbccjktcbl+cuDWzojZqm4CFzDx
         VqGdtgA26n9LBQsl9j5YmbyTfOVCUVUCFzS00V3X6U2UZEWd845WAflpdH+hEo50iAWA
         SwiiLsmC263CmFd7nt3ag3qI38cVMOvMvjic/TtOhsy4JX9lgCFMFRLCVTVG/IxcgPNm
         rNuA==
X-Forwarded-Encrypted: i=1; AHgh+RrCZrneBMr1ITi9VRDgH2Krmm/TKcXYiqKxMPAjtHzN5ldM3u4u07doiuqlmr14pz/SJhCP+kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQF1frciDTpDE8NEhl+RkYbOJwmodllTkYLQ5sdZ5vakBMCrbg
	N88u95/71kpY0aEz/QKFclzCTCKa22gsX/0coUgwsTQvceObpABMwjwMSpbIOvrwuEtu6fNSzq3
	HPFyHMkOlc3zbTKkiX4b4eH5ec41erMMNOb8iNvB/
X-Gm-Gg: AR+sD12zwfj3OnPc/0F/kGXXHm5nm/qZHLbEafRaXDBye//yKD5GVy5QQy7ZGw5U+At
	Tpzda/8lK7dSLTWKnWVEzLhL6Df4eZC3nBMQNGhCPxp4f+Tc/73tekLtEAT7ZRYySfvhiygVI3/
	ldUuRpO6oVPAPg8nnk4hJHSsHB3oso7R4IC5Dz11yak9h6/M6xhkDfOLLOtGr8idFssuhJfXjmQ
	J8Tk6vSXO7j1EAs8oHjIlVrzBWiLbkrEuirru/X/wOMAjY1zI6R+nB70pGyFlSlieNQ+R2HndJG
	moOk0Vjd5cGEw4EyMd2xv2LrqNH3I7Ah2FE4F+QB0OA85Nk8LgyiH3NO0640NwZGumZnW66BW7U
	UIADVUFF+pZknuKtf0t6AL37qpXGw0gpK6RIBx+p79VIyhvWMOQsB6S4=
X-Received: by 2002:a05:622a:5c1a:b0:519:b5ef:7fdd with SMTP id
 d75a77b69052e-52b5666c4aamr282275791cf.6.1785855705379; Tue, 04 Aug 2026
 08:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785823138.git.rakukuip@gmail.com> <6218aa3534d0d2d3f448fde70a8dc2769d7a8201.1785823138.git.rakukuip@gmail.com>
In-Reply-To: <6218aa3534d0d2d3f448fde70a8dc2769d7a8201.1785823138.git.rakukuip@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Aug 2026 17:01:33 +0200
X-Gm-Features: AUfX_myRYK5h5EqLM3l3dY-aqNjZceMzS2Yr38y86_EP7ctdV6zLk4B5bfLoFh8
Message-ID: <CANn89i+8EawQn7o2uCosBXDy3VR-uTdxYwjvt3NzyTPsBySfCw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/1] bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie
To: Ren Wei <enjou1224z@gmail.com>
Cc: kuniyu@google.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, lmb@cloudflare.com, ppenkov@google.com, vega@nebusec.ai, 
	rakukuip@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:29=E2=80=AFPM Ren Wei <enjou1224z@gmail.com> wrote=
:
>
> From: Luxiao Xu <rakukuip@gmail.com>
>
> bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie accept a socket pointer
> 'sk' with argument type ARG_PTR_TO_BTF_ID_SOCK_COMMON. However, they acce=
ss
> sk->sk_protocol without validating whether 'sk' represents a full socket.
>
> When a BPF program passes a mini-socket (such as struct request_sock or
> struct inet_timewait_sock obtained via bpf_skc_lookup_tcp), sk_protocol
> is located beyond the memory boundary allocated for mini-sockets.
> Directly dereferencing sk->sk_protocol leads to a slab-out-of-bounds
> kernel read.
>
> Fix this issue by checking sk->sk_state !=3D TCP_LISTEN before inspecting
> sk->sk_protocol in both bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie=
.
> Since mini-sockets are never in the TCP_LISTEN state, the condition
> short-circuits and prevents dereferencing fullsock-specific fields.
>
> Fixes: 399040847084 ("bpf: add helper to check for a valid SYN cookie")
> Fixes: 70d66244317e ("bpf: add bpf_tcp_gen_syncookie helper")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
>
> changes in v2:
> v1 Link: https://lore.kernel.org/all/ca8d8c570509b02355bb4bd4e56859f3e256=
4c9c.1785576172.git.rakukuip@gmail.com/
> - Check sk_state before sk_protocol instead of adding sk_fullsock() check=
 (Kuniyuki Iwashima)
> - Correct Fixes tags to point to 399040847084 and 70d66244317e (CI bot)

OK but I do not think this needs a series, a huge cover letter, or a
bloated git log.

AI will be able to rebuild a cover letter (of arbitrary length) and a
full repro just by looking at the fix.

Reviewed-by: Eric Dumazet <edumazet@google.com>
