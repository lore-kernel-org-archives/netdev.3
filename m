Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794055376;
	b=zb/QDc3GycwQVLSJs7/XdEmXShPmWoeBovrmpZawNStV7p6BIzbxPVQ2TIu3zUZoe4pu
	 Xn+um4vGK2JdcSIRjbIlLWpZVtJweDv58uIMKghVd4MTPYu2ulk7OLgniEJp8ECOmR6sA
	 nV/J/7/XlRksxQIE5v/OBNH9y3BmOAuZZN5Mree3Qx+7vMTpGqLQVYHK7aCo4qqlpL5oQ
	 oCkYeKxkgZ9wvWuN3ZEi06i5SpnuCOMp/qGdtQaIrvfQATs40M5EHcuy/OpeG2jqIR5DV
	 FjKwYZiwx8c75k3KGEu97jHSBOz0vkKN7ZEsXD2VlEZ7fQ7RV4eRUenDl2l4Bx56KAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794055376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=hoTrsbSrkMdrsQfhD79O++sunyJzicHmjD/fVH7fx2E=;
	b=1RhGVeWwgm1ZXb4W9lxDIQla+6tzxklrH/W0BQX84YqIV/1WWhx+aCiVk7u3xWzr4ISO
	 A/W72xlrG5LO8UvprBRBHync7A0wnpnpDtWLUv3RTxUsARU91pemnLn0ce51nfXXQtGt+
	 hwGx1ULrshOj5NVdB+rEUkmDNDBgKEZ37i/JUjDefYFpeB0v13MyUFVJ0sc8UE91WBdH9
	 QS+aWhrcrbksEb16QP51f3O7jglzeCB9pACnC4fLKO+QjcQ/LHUQCH3A/DTBc1kzBHN3a
	 ZweJJczirOs3vJkYmYr1h8UpyQA1vhJrEkLJT1xEA2UJSPvQ+mkm2MwOJhDpI2Ojzbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gGLL7jjd;
	arc=fail smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F8606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 12:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F3F8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gGLL7jjd
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43bf9548df4so1493976fac.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 04:42:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794055375; cv=none;
        d=google.com; s=arc-20260327;
        b=DbnTr+ZvKL6cY487v7c7V2yGWxg6qhbL92hgzJC47mocRzy8WY4YCPxH+zg/P9okQp
         V7ZKRN6k2QLMTJVDByjzAUY8tEjzQLk+HfdScxeIbuAZ9cr6KPMC1ht60Zm9gds5TYLS
         AE4TXVQtfQCVB1wH/3XdLJotECB33dVj9QmxAPU4Vzaez6Yzxz0VCOn+mzV9ZiPo/ZNU
         IdK6/Mv4mSDBTuXJmKa+IGNmx1bvopIQgUySUMfGPWlLMpobJCVoHh6EEvodmcJxrcDQ
         WZiOWDJY4+pkt3MscSRrIY/QA6GXwNJFP4ASDarGTP7fQzWx13249nig/wcQ5nLZ2PyM
         jE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hoTrsbSrkMdrsQfhD79O++sunyJzicHmjD/fVH7fx2E=;
        fh=apboHd9+R1dvvCkJdZDZKmUVNsbKVTk7ZyeK9b5N4V4=;
        b=I6/GGUvxKu06rY5JT5DDSyUS7d1k0akY27+zXg+Ouoa2D59O5fYc1/d4vnG9GZKY6C
         1lDTc6RF3JnXQ8GASIJUYqMIUQ7pcPl0o3jm6G3Vp9SMO41HciaCjbxg79YbrNf/y6Ep
         YQ7qrNlZNhRA5KsDnSW8snGz68snhzrMcFDYv1nzcRww3pQ6UoV1QYJ++OX01an1pvDp
         gxKsh/IZmzdnFe872RtpiqTd8/zlEyRWA2MeIhhI9MhQxSIWsWWlbVxUkj2D4x6BPjUn
         96v1Y29qNxOIzX2wCa1QsbnA7mkYOWYQgsXYzio5SfbQ9+fkSLrzXSP6hKKCZPJraK6V
         kznw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794055375; x=1794660175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hoTrsbSrkMdrsQfhD79O++sunyJzicHmjD/fVH7fx2E=;
        b=gGLL7jjdeualKbXWs/iTByZ9gFd1Q6UnzgM8t2wJn3VrYGbWc5EPiMOp6UynDB9y5b
         vfVJBdcLPwfCFKbJM8PtTJufbF9fmnpGHxIfT3QIFvB4r4dO6d+Bk/jeQqdusD3PSqX1
         lVTXVuq4b7Jrz8ZKzCnyPWp/jyD5tHbYMib6x+4UnhRvqLtesmqNgQH2fcqKVrE0NRUI
         GLJVDAup7Wtw/SzHLu1GQZ5GbKst0iwH/uNjRLdtx4SuX/IgUdyq/mmL9hailCpmCTDs
         YaI0j1EHjhPlu+EbVq8P+zSqwkAF92D+vt/mltbaBJItrKog+ZimNkwGBatQUGwTK818
         YPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794055375; x=1794660175;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hoTrsbSrkMdrsQfhD79O++sunyJzicHmjD/fVH7fx2E=;
        b=bdCRmIhoB2msNctf2VmtTuG4Q9fZd3ZVeF6/jbHC6pqR0f7U0+fhsQr24QVI0MRDa3
         k6wcubzwhkaZOTBo19SzuqZsNRjPsnITbrp/0Go9Jwt/1Vz/D1E1Q5rRNNBSCGAWwzNj
         et6NcD80gBpUgM23MUjcuM0vngiDNEwYq0CTSqO5RDCUF7VgLML26rWBJnCdyikNZBPG
         FEBeYpwVQYkeTtuYDL05Ds1+Pp6nQlpYFq21q9sh5mti8CwAA6IHhXknCV33Aad7/118
         MSw4CgGEuYrTUC+hj3Tv3MCRJ3qmfQ1zjcqq0W0WrQ6AGoaX+sUqH4yFvBKVLGwUIvVW
         3bVA==
X-Gm-Message-State: APuU4Z9rgtWobjQUA6iqKlpZzlRcfgfKaSfUgh5fVgiCSlv1fEYFEbB3
	LvYrsKbsGVPsXSJhCBp89t67yWUeizIvRKIHIrvig2AvqZXpDJC8MEfkrG1hlhbP6Ibf0TTJhFn
	9Rb/ZALSfWaOJ3fr4Yk2cII3xlQepvNM=
X-Gm-Gg: AYBFou3GDqUCzix/pLVnT7DGEEMV1Bzvx2jSDG1EAPmUWXEVgMSmifq1rSTuOkZtV/s
	/3shcZzIOIsnMtKIjtzLjT8DIIJ0sFO6YqbAlu58KMJN6eONprvqJBGB65C9BEhJm9uGVMNxgg4
	E3O6yns8/y9YZ3T8XogiOL+e+/3e5kL6m4ipdXQayvaUrA7fpa1UnainWJbIwRzBauiF1Uuigm2
	UtELRAyx0zbbnsP4qre642qW5ZehQ4+8ZxvrFG1SUwYDIhdCocR/uXvPZ379c9XWZpdhUpQrnKF
	64GK35EWrrDlkKZMObXNsyJanN2+EbHrLKPBG6oTez1jakYJS5dRw/TH6PX73jRVbh5eqZhCB33
	phlTtBmxNV2ZEDsN48MPYEfGdozainww3eOeZuQfpnxhFFw+W6Rd1XgIFY1H4R2TBU8Ykbl4=
X-Received: by 2002:a05:6808:2218:b0:4e8:f740:f03a with SMTP id
 5614622812f47-567e14d9018mr3699053b6e.27.1794055374970; Sat, 07 Nov 2026
 04:42:54 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107121631.1040612-1-mmyangfl@gmail.com> <179405408165.488859.13345893308369940626@kernel.org>
In-Reply-To: <179405408165.488859.13345893308369940626@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Sat, 7 Nov 2026 20:42:16 +0800
X-Gm-Features: AclHuK8F-482r_fvHFZmTramCzRQroOldrNA_IqtW_BYdZJBshwRBmNvD02UYRI
Message-ID: <CAAXyoMPBbqAOtTpaoT2Ae6nbgU2aDjYyqmtgm2-aCvjFo44ZEQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/8] net: dsa: motorcomm: Add BR_FLOOD and
 BR_MCAST_FLOOD support
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 8:21=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

not a fix
