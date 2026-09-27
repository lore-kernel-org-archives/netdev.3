Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E883F58D6
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790518040; cv=pass; b=Hz6IhqPoNySDcvJWNsJD8eQAiycESv8rZMFh8/2tVaWd9qOzQrv1uQhm8Z8znGCAx099I8vIKpFs6ch2lJpSn36zYEb48HZCnjPhxYLrhf6zjKcjNyQbsahZdK8KeDNirnBRXXHR9jlz8ZeC9FZOlXbL9q/gYt5SIjebv0KUGQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790518040; c=relaxed/simple;
	bh=btEpaMCWQy8KnG/IttUdumOkddYQrL9haIDMPMMmywE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcKzNmgtPxS6XuCEL5WqnEcYnUn+lFDtJS3BZilTsjS3PgObVXKTugqp8q8pVyiqNzrZdh1u4CfAoEFSTjvbfYRMYVRuoTu0YEAcQ17YpSa+m9oVQIjv4FxOwG3zaVgjYvIOKmIc0quVcjy9+ml/G7GkISR9yx2IrekDdWzWZzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2/afTA9; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2/afTA9"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaf2ab41bbso204695a12.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 07:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790518037; cv=none;
        d=google.com; s=arc-20260327;
        b=PCSnKvlNZqDnVY+OXEDzt1s9RW4AI7QtIs3Ei4OhucRgC5ILFWcKdM/oEIup9H9VGN
         wtJubAlaA9rXNpZxkORN+6be/I0NL0L6kYlyEjkP/Bah+Qir+flXq8H6q+Lz+yJrjmjb
         zZV3kO5xCKZmpzFBPak2hVFuc8hTht0h4a6ijPBMttritsRsChaxrvSjCKBYmv68jHZL
         56rRLtVEC5yyJE/hHmo8Wc/yp6qT3w07DL4/G2hIG354hoW0Fw4Wvgm9aPd0Yb1l0bqy
         ivGIliyejKHF8r+yej4sHkEDRJMTK0Y3jYmLROXqc99XOG9lGhKQiJyAp2lZlQ/Q7ojw
         T4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=btEpaMCWQy8KnG/IttUdumOkddYQrL9haIDMPMMmywE=;
        fh=TK4pEyEjn2E9CFZsvx/fE7CZDbeuXPhNqPQq5Spas94=;
        b=SiB9yhA6qFlzA9WWGM9te0jwdP6oJsx0BQcAjA0Act1WkL/S8+i+GexMuaUn0wuJWi
         O1jnrsTGqdGvtykkm4f6kNjmZF4o04Xk0iRVVUdVx+72fCVuUo2HzCAwWn6VpEtxl7bf
         39NKf7BLRxRVKERr2dD6cPMPP8MMDBOEr4pglNV6rFQAvwjsw1rrJIqo5BQ628aS/XBr
         h48PSz8hbvWx3HCprSsOd4RkbnaZA3cmpPaf9OEqh6Bepr6NmKw0vJ2FrB3pnYWIijLb
         o2Ab3vrwjgviW6EcTTmC59GUKbOfDLMkZE5REILKiB81Y0ealwUlSwYMSdGKVt8mEGEW
         tvmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790518037; x=1791122837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=btEpaMCWQy8KnG/IttUdumOkddYQrL9haIDMPMMmywE=;
        b=D2/afTA95f49OOCyaY24lT6thKIDGHDkLBMgZQvck3aJCGot2AqAXoM1nhnk19G5gK
         KtLkUxxG8ih38iigoWjqsczVtbRF+TuYUsBaLZ3jdAL7aqfjN7PtXLH30dgv0XpKmSUK
         Hda/CaSh1Hyl3CXdyM3gFoo3RPm5G4eHWvY2uXyBlLHCNsOzLyo5xVD9U2F+hZQGp8dR
         6YHzU7hmXBZo0N30+wm7Jp3T2wuNiz/Rt4N0UKlYVHtKD5AddPgHBkHYy3AwCTYl9K8N
         wos/DNPWfk3sxomp1UYkQQOpl7fkk6oB/E+/hYfK55lBMwaDwvraMtSVMhpAsezcZHJa
         ucvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790518037; x=1791122837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=btEpaMCWQy8KnG/IttUdumOkddYQrL9haIDMPMMmywE=;
        b=DnF/VU+xDaxev5ixBP+5thu1TN8BebGveana5tFRwoRgfNexpZ41BIQcZ4GMR2Wvvm
         i7mVcHtSwuTJAsZE9j0/2xEqOtBLUIcbsKB9VPvidO9rQsXsrQ57nBNBhIZ4P6abNPq2
         jf4IkuhAq3g/Lo8+vFRqSOv1NhnY4fMMXESlsb9P5EmC3ppQEMVc4cvEuXVCa0GK4RVt
         k5bxR0sqlP+ax8A7t0IHohclEidA3iiTta/U6ggt0GeCwzHL6RfLdtlJa2TpUfP1Nbc9
         jaQV/8b1oJby9MwSsSXs5eaOsDtcgna8hUdQ0Eu0uP+VxasYt+ZCCqmTgKty5mMQqoaZ
         sH1w==
X-Forwarded-Encrypted: i=1; AKwUvByn2z7NjpX8hXYTygaS+1VnGOMypTxJ8cUlcMBAko/jCk4BCOlkYf2ID09mpmJAV6n3DaDTVTE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgfv9W08ZFWMoaexo6EwvE8O0YAQBHYijvv2r+aM6rXnBwiU/1
	RsTdvpzVNajf7mo+Rvkf/uFA1DIQPU0TjzFVyMg0iSuSeuA3DzVOpR5eWvGqfTsHP/EZAQHb17J
	qB6sd15LG2631OqtMHJ8X2KtPe1F/lcE=
X-Gm-Gg: AYBFou3ZUryODmzd5A2/bdWvdwx5pwBTGGenb5Ck+q5yijzYjqlR5WrQzDUU17CYTxN
	hh+5oNmNFGPBFD+9pRmcopIHxhoEnkghy4USUzSSIPVfVQqCA2g0wV6kmykrEYgVEz7YI1N19qO
	FtSaTf5ALz74amxjDqbWd+xRlpMWgCBvtlPvygy9Oh2iQNXANLdlokCaSaA7weApTQXZunvYqb6
	rzthuLE67lX0yRH3sR5/hyYzz80vTfZH42iliEHPyrjPClQebaSjKpO3sqJJPDDHkGZYasHKvHP
	6tk7N0fFWm+RV3q0XkbEdhJWPdKhFFKNl116ZKsOuMdJDkbeMrcD5ywntLy4zWqB0/O10fHbezZ
	Nm0sQDf4JvhKZdX6huVvEKg==
X-Received: by 2002:a05:6402:84c:b0:6aa:a78a:6a05 with SMTP id
 4fb4d7f45d1cf-6aae1a75d8amr6926922a12.0.1790518036568; Sun, 27 Sep 2026
 07:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824152331.216494-1-nicoyip.dev@gmail.com>
 <20260825185313.239861-1-nicoyip.dev@gmail.com> <9397cfcc-03ee-4269-a9f9-97df1f454ebd@redhat.com>
In-Reply-To: <9397cfcc-03ee-4269-a9f9-97df1f454ebd@redhat.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 27 Sep 2026 22:07:04 +0800
X-Gm-Features: AclHuK_dPBEhsvAmrIGJX0etkLRLKkfvqri0XmzuWMrBwb5evay-fQetwCixOjs
Message-ID: <CAAo+4rU1LSjpaPmXzSrM9AYDhaPksPLq_Z27XzTNx_07HYBjgw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: pktgen: return bool from __pktgen_NN_threads()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 4:16=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/25/26 8:53 PM, Chengfeng Ye wrote:
> > Callers of __pktgen_NN_threads() only check whether a pktgen_dev was
> > found. After the RCU lookup they never dereference the returned
> > pointer, so returning it past rcu_read_unlock() is confusing.
> >
> > Return bool instead and keep the pktgen_dev pointer local to the
> > RCU critical section.
> >
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ## Form letter - net-next-closed
>
> net-next pull request for v7.3 has already been merged, and therefore
> the net-next tree is closed for new drivers, features, code refactoring
> and optimizations. We are currently accepting bug fixes only.
>
> Please repost when net-next reopens after Aug 31st.
>
> RFC patches sent for review only are obviously welcome at any time.
>
> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#devel=
opment-cycle
> --
> pw-bot: defer
> pv-bot: closed
>

Hi Paolo,

Sorry for the late reply. I have reposted the boolean-return cleanup
as v2, rebased directly onto net-next.
https://lore.kernel.org/r/20260927135406.3969970-1-nicoyip.dev@gmail.com/

The original UAF fix still applies cleanly to net and has Eric=E2=80=99s
Reviewed-by. Could it be picked up from the existing submission, or
would you prefer a resend?
https://lore.kernel.org/r/20260824152331.216494-1-nicoyip.dev@gmail.com/

Best regards,
Chengfeng
