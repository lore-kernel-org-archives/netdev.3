Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17292499F1E
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791413040; cv=pass; b=d12SbVf00wClXY9LmHGtrCIo9K0zVYw23fuskcJiyH2I1tdHDSbMCwhAH7FQ54SKIJAZBizsW5TvogUngAzYC5Whgzw+uTeUDhEE3GjRNA4UkwXau2WahMM7E0PhsreR6oXHB9PmrWbP+nPx1T6cfliTkrRsWaRPu4AF1TgngXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791413040; c=relaxed/simple;
	bh=wXp2WBZ6eLi9RGRaF0tTcJdYbVqJ9eGOd7s19JkBV3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8yW+DQn2Rcd5Jo41q2P0CLHiRYlC+qJOc7CqiPD+sU0E+KxQZsWjNTt8HQwxyJRtgZWboLO21MyNFhc7KPYK6SkxMpZkqeeBkNLgqrugyJ/uspubYLn7XOzRvl4e42KjAyKohTWC0b0WiyKNr9Q16toePzgZq4+9NiUpahtPjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9S3yJp6; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9S3yJp6"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f432ac553fso3402281a34.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 15:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791413038; cv=none;
        d=google.com; s=arc-20260327;
        b=lkGZrmK3TN9UPgy+E/3P1KoBNQjDpAv94KbwP2ceFT5vHMZLJReKMd88antnPEafaa
         v3rQJ2HuOLCcKGoy529cqFErP1K/C2gCbKWXKsDlDrO6pxNkveycvk/igDh/Gx1wKbve
         pJWL9tFsk9XlG7xug07BOeU4JjRDJPAcRKp2gCo0OrHv4kMhZHmyV2maM2TH2FBm+HXj
         fHbyQ6KnnC74l5O64r28b+G46xkBb06IiLtFDxNrMT0uY9P5Kx7cE8xAOTw2taOo20AE
         Qxq60QxDuy4qKFI2uDcSPCWZWPjolByEvXU/M52jqktXblWInw6rVn8ca4wzeew9tmH8
         t4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f4M4ighl28LbuAofTn6rcczAbDWHyquWNCn4KhlT8Nw=;
        fh=y6NXVJAwp678nxBt/KjSGK0NnjZlwpT1c3QJXFdJo1k=;
        b=bOwHY5AICM5Mv3Gkj0mGJXRs07v4e6b7i/Pp/aJXc7834L0Tb3K/6jTytNRQGA0a4X
         EkrxhA+ZNWV6I+x27eBpStPwoi/qG+enjtIlsnAMFnkoyOByGDQ8O6U6FHZsumf2BvPu
         i4jrexWOzAHssccF6ghUg4A6FUeY/5JyZ5gPw6dO5e8vSEmfWlJ+YJzbnJMCUUk2ybl5
         xIYD2hm9IKoafVh9MzCkc+e+faIL0UaVQKbWnj0CFRAZKjG1ryNSW6gNaACKoOt1Xa3A
         k9nzHwouLlNCpwucdFBq8qsPT2e0qi61NhTx6jkWFtjwbiW/mCiu+UmEs/7PPeWTFpML
         sOYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791413038; x=1792017838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f4M4ighl28LbuAofTn6rcczAbDWHyquWNCn4KhlT8Nw=;
        b=X9S3yJp6KNPEFQI0rm3WN8SI5+J0vUXT+n/X/dVpMFSO19WIKpb77LrUi89t9PKOHO
         i40j9AUxU8cNWO6Bul4lOTRPoPCUqlL0nKaWCVORV98H19cNGVw0C/W3iNZU+9RTB6pD
         GkiLNWv02wTJDUzywRWGgoMZcnCY9EbvqlaFcKy7W2jv66+oZE34ZyF2TrF5tKOa7S94
         zDeelqok7dIYEamTTNXX/DDgktvdkbiTHALeB2+IKcPAZg6ZuvaDLXbmACYoLpV7mvbE
         6QehNK+CzJZOkUNvBstc+q9OmoM0j5/hTCAUp0/rBS2L/RyUHm4+4LHiJTV+YIuaiicC
         Zcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791413038; x=1792017838;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4M4ighl28LbuAofTn6rcczAbDWHyquWNCn4KhlT8Nw=;
        b=ILV6uMybXhX4zLQd9j0hccsFn7osjB7i1tF797DCASCAMN1Vsu2+L21uxAmOZczYNH
         fSG7qHkVBW/M8xRVax7R4LRN92/enLMBChW0a3U7a8AqLbplyeS6cv66uPoeUN/erbfb
         FmN9nwwcbi+4HLGT4nd1mOcOMOl97X+iw/Bcs/E49NimhF1sNmpJbvNHvawhetapgLsS
         2MArMMYYa8PJZ7cnD3e4awogcrK6a/2/yih13r7mRAubul6rzZQrMpYsfcOkAuCPt/YL
         LWCzgJqVL3AsV/+5ZIDIjSuTqliln72tsEEENEgIKWl9WpkDHFE5P53Ymbr6yktO+mwf
         9gaw==
X-Forwarded-Encrypted: i=1; AKwUvBy1qDFc2GWa1kFECJVbqrjJwOu492MzgSyZMKuo0ls9vtDf/s7sBXS55x4kk+dmz0Xo9YrKWWk=@vger.kernel.org
X-Gm-Message-State: AFuF++nVbikWQTL3k+nnWiorhXuNox5SmvtqXWaMDJFPPjNSkoYQdPR3
	XllhttKjkmKwXTgdjLDoRTOMbykjdwkGdDEMZeLXlCxsmzioAWng/hOGrVpWuYyln6gxVoUVz5j
	waewi6ftxQ4FSHiQm5vSTni/WUHazX1Y=
X-Gm-Gg: AYBFou0tnWvGn2o7tGixcO9tGLE+URBalH1n2C3QULR0hjdDrQCnLF/aaFFeXsn+a1W
	OvLyaOR8uzQ+4Rzgp/RP0GXD0iHwkuGEp/DZJfrTbVV5NviuYXjrRJJfgkISQowKO+b7fkIGYGj
	z7ws55N7RA5gUrJX7LPlxfq/h8RqKDQ/CWlHRuzF5Pj9ZEssrc/p0mkfCzdT/AUm8v+QZD+zn7r
	PpKzsrF5VfbxQuBZwBb0Kem7q2ATKF0MkKqVOoZBFVVHLDycfavXjpWq1Isb1OGbF14Euwsq3J6
	hBU2ktjAegn4VkkQ6WpFeIiEnqHWskWpMnJjVTYEX/lBWSJ+d0Qql0uY
X-Received: by 2002:a05:6808:4fe0:b0:4f9:e0b0:37af with SMTP id
 5614622812f47-4fc4668327emr4385313b6e.27.1791413037808; Wed, 07 Oct 2026
 15:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-8-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-8-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 15:43:46 -0700
X-Gm-Features: AclHuK_UHYZ6uQjTEXs9YCsW6Li1_8D6VcWKkqcNEb1mLMqvBsoPzksAsgte3gA
Message-ID: <CAMB2axMFXNUWE8O14ONHQ8dpHpQqzBR_BeG4Ygd7PR9X=LuawA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 07/10] tcp: Split out __tcp_set_rcvlowat().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> We will add a kfunc for bpf_tcp_ops.{enqueue,dequeue}_rcvq()
> to adjust sk->sk_rcvlowat.
>
> These hooks are triggered
>
>   * when the TCP stack enqueues an skb to sk->sk_receive_queue
>   * after data is dequeued from sk->sk_receive_queue
>
> In the enqueue path, tcp_data_ready() is always called after
> the hooks in tcp_queue_rcv() and tcp_ofo_queue().
>
> If tcp_set_rcvlowat() were used as is, tcp_data_ready() could
> be called twice for the same skb, which is redundant and also
> confusing.
>
> Let's split out __tcp_set_rcvlowat() and add a flag to control
> wakeup behaviour.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
