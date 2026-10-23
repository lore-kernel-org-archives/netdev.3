Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792781652;
	b=isxGjxUErhJpMioxCweAVLm1N4bfFypcRrtwmIfhqmw+/yzX6boSnYwHtYmkVOppPJwQ
	 IHQPQ9EKYwBGQ7VOHRPtEBHwny+JUyuYR0e2T8Eh6Z85D9bxH2BNzyHBISGNy+NT1PGKO
	 LdsZ45+IMhdvCALpzur0kGqoPv9VhkbFtbtEKQwq0pCKPpX7UlaLEdUwB5P0F3zV+krSM
	 2ta9OZF1p2q0CDctMN7QTmNePpoyuyLOx9cXco4y6vQageGY0yhtfaeuTzXU24gmqBMon
	 kncjvNtpbsiFCoT2QL7qm+ELV1ikAgnfmtlbS1pKSbiGKgW9D6koKJv1OQkxQkd0WPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rU1MJkNETayS5var2MLHM73zlvbHQxyivwE/jbKWRfI=;
	b=KvqHIjfSTL3bCLhQThscbse5kR9PxTZK3e9Z/lNSXFgZi7xhcUT51S2mAGXtrIGfwAfn
	 iVZS89zbAkOShYXyZi0rXpqYqH5Ne+Uf4vLCFQf7jcGuqPBNXCG5Rje1MtK1duiBZzibM
	 TQIQDMRnHGXHp+SsgX7giulwPyN48PBNUuANXF2umhBm2sYdgWnl3Ii6wbSmQV9tShggF
	 +uhpM4jvV3FS6ox6W5C+tOLLMkr0spu6oiK4qSf+jFCbvNyS/PVCy30PXYyaQXqe3X1BS
	 VMa2G3IhZGZc6PsoQhbnkW7hMygCgydIt9U1sps+D3udkWjpa5c/wlAjSK8VaL+Xa+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tH2PzqGf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB60606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 18:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BB60606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tH2PzqGf
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso7772655ad.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792781651; cv=none;
        d=google.com; s=arc-20260327;
        b=GuT+uMcC03B7+WyuQCEU/0k6r0j65ICPxMtTysbUmPv6yL2B89yI0hOTiKTVkmsqIJ
         prjPxJA0YVnUSVLOKg2asDcUFOQVPaZ8vUo8KfLe1QjX83H6qdpbXg+xUSZ1jBQITbvd
         EZSl6jz5Jnyvr7XssliLp3RhoxT4cy7X3U51hGFI/8qk+bY2HbYxCjJFbWinup/oEx7H
         7oE5J04Xdhh/MNVtMuKxCG7yXbHmwL9kRVrXPI9KPaZOxVpYUYvkFWlAfGI/7xq8Qa0p
         3FCfMuGZMUfSJB0D9YrO/DbpRNCq/XluuyjHUtgo0x0O8qDtR6NKxf39QeWgGbTf0dqx
         7p4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rU1MJkNETayS5var2MLHM73zlvbHQxyivwE/jbKWRfI=;
        fh=Q7hDqG9WdXSmdug5d5kxBEF2qM0ZV/72Jx+V1rHqgEg=;
        b=Sw052Tf6RsNXhNw59uGXE1esZtRLlR9DahO75BOiO5DvGzndx1ZrRpxnsGgRntL2+7
         ZGh0dLMmzSvRV8xo20pttdRCtVh2I4yDNuIzgJ9TLgryZVhxwEqb62aca3AuSrtDXxpG
         cnUp09dLwAN45j3cFi299fl1KOfR0Gv0kNqUvwWYkHFNozRoalBxzKDyFaBfMMsKGPUc
         tcfcfqbGViKlfspaj66NjsuaLyPtNrI3VWysGMtK7wacQKVJ/Uhk+Q4bkhySYW3fm6ng
         sQJfhHT6LxEzELcPIhf/ryn1IyJUO05BMsra2/K9c5otUjGpn/btFZCPpHckhVw/PDLe
         k2Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792781651; x=1793386451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rU1MJkNETayS5var2MLHM73zlvbHQxyivwE/jbKWRfI=;
        b=tH2PzqGfBFXUmYs+U0jgxOiwBUXW3Sw78Br9mxWPzz5zt2F/svzbOMPh7lEjoo0ZZF
         j4GnojgKAHeLSLFGyEgfvcNDViTPG1998Y3gip182ruBL9vYQn2kZhwzRfOeE9Uesj/R
         vdFD5yriZ0SkT4bVJF06piBN3APb0Kw5Mm83EkuGYOwakhTMz9WbsK3KFfPGnF3mozS2
         yClmI9XRaHQq6aP5NTLJiyg+MsU4X2lC8YHiDGHaePt3mfBVrlpQLArFbSkgnitcTgY9
         S7fliGBzS+AFcqouePcT12CLNclcTaRsKMMIchljQFSpeFzidMIwVg/2q+9HutAJZWLk
         I9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792781651; x=1793386451;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rU1MJkNETayS5var2MLHM73zlvbHQxyivwE/jbKWRfI=;
        b=ckOyfKQUsoYa2Hbb9ENyfwALXhZFAlV9H5ZhqVCVEG74DyIG3S5uhsFMoFfTtZUAOQ
         YeqZrCumZvKzg3RwMlBsoEo5PCrN+Fn5nj4khuOPt7LfSrJghaHtEodV4TZs1+zI+SU4
         3Gy+KGSB8PjYkJriVbx062ksj9Wg77tJ9p+lEXdcv86WQYMAVUhSJd1QPK8mxLS052S9
         9Vifg6jAZoN8V/aHwByGd9NFTDHaME3i7FeDQDpg3Rc7YNzYa9pG9UOWnN4d7AS4JAaZ
         tsvHRqUN6RYgsXu/Y808IYiYecou9mPiifgX6hMN//ziz5bN+koaX5rCaU6OWz44Knk4
         MRDA==
X-Forwarded-Encrypted: i=1; AKwUvBypEioc/LuZeUSWDc0SQ/8wYh1Dh2AWKX7TBAADSKs96PLfWJySkiLeS7UP+yUC4LR5p2yj+Qk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvN0SY4Tdndv5NM0Vy6SVR6n83DcMMQIijG4E8g4ZjWujlRr0G
	SNKkyHOLUnOB2SPZGHjVIP+iACmyEWkf6a+CdVjyaJhhg5OwVEDk5vQytcP7DAjQ2qWx3cF7EkI
	6ku1FOSDUpSU/zhf5TdgnZkMtPgSAycs=
X-Gm-Gg: AYBFou0f6ELyuAuhd3slbSIoM+Kwhq+9QDN21cg58VXljHKR/YdbIThEudUdLivyt5U
	b/BOS7jXa6OjBeBiSinzi8uErHb5PwZVLUSozyJGFkMfsD+X9x5wPUcfF5Pk0cof1rrp9TfXFdI
	P63S/2L5YTggQ4NhytzsrmsViiWc/AESWPS/NSC0MTgSR1YbmarEpmKalJjpBUdTQagqyKKhWTC
	5KLZziM3deDwwVH2x16/5EZ2WBobvXB4lK/RLME2v73b3Pm+ffNLXijWyNSQZMeAHnzaE2bYTtz
	ZTbb+5BSF+e7H9l6ctt5JygNJ3JPiS7ZMuk0X1pUaBcVQRmGdHllp9X2j8RA0XVGMwaGz5leZqW
	d0ZMhZ1a7rNg/VnBHkCV2RRnJGFouavA3zX0lqEV/abvZ2Ob8T2m37J0O7+2riaHHyGIv/hhaQm
	aFth+mfDTIaI5FYC47RemnW0QrOJ1b8Y3q7KZGw39BZxNHGpVEbtE=
X-Received: by 2002:a17:902:e88d:b0:2e2:fc90:11a4 with SMTP id
 d9443c01a7336-2ea7c1a473dmr29006745ad.48.1792781651387; Fri, 23 Oct 2026
 11:54:11 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021155629.68813-1-phx0fer@gmail.com> <20261022054811.35008-1-phx0fer@gmail.com>
 <DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> <871p9g6ym1.fsf@cloudflare.com>
In-Reply-To: <871p9g6ym1.fsf@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Oct 2026 11:53:59 -0700
X-Gm-Features: AclHuK9Z1e1uuin3xKQj50QTuiC83gSWuOAbPYUtr_-0P4Nt2Rm5eucO2azxltI
Message-ID: <CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data races
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Dudu Lu <phx0fer@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 11:49=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:
>
> >
> >  static bool sock_map_sk_state_allowed(const struct sock *sk)
>
> Code LGTM

Jakub,
Could you commandeer it ?
Dudu is clearly a bot and doesn't care.
