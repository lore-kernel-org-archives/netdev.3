Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02108434E4F
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534755; cv=pass; b=ntXJ5kMWnHPJuyf6qYIuqSOV/T34JKqE2utPGB+XzYFFTNqCOqfO8r0YVKwJU3iWDNeDvfgXhDWfsBFr2KZVN0qJSPe8ANu7WfFGxAW/FgCwPQWHXzh4U13g95Uri5wiPBC1y3yLp9pWiVCtnqs93zMbf+s+FR4VgdvxhObHeh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534755; c=relaxed/simple;
	bh=DaN9nYB8FBMgKs+20JyrySVlwZ2Qv/MvcqfuuWBsD4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aezsOs9+K/16xKYpgROj3F3tx5AqtNg7R9E6Gc8w1YsM4ZNH9JmITuwLX1OeT2aoYGPycYb04FTRKhhVD9XnKMQkwZzUiRFU+JgUvkzLFsKLhFF2rg3xI+oqATap3Jf28P/84whS98A/m0SEZYJOMACFJGIXypMiTBEYbSDdi6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PuXSz90l; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PuXSz90l"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c05dcdf49so10314761cf.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 04:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786534753; cv=none;
        d=google.com; s=arc-20260327;
        b=PZR4v+/aLFC2rxVzlLb3vVVIicL0LkAMKzVxA+0F+w48GcuuCdLDtpflQllPFxcEUk
         hepo9bFjhfhscWGgnZY/leo1WfS1CAEHGg1wBQIkia7BCz6749CtREzegIYh8YLK1cbM
         DQMrPpYfzshj6Hy4dLpCst8/ECPJ6C9lNTwUF5KwBK521b4+VcOPLfEKo3M7Z92UPle4
         CAeUq6y9bZ1rG8bE/NvldZRqBToQwWYarjvjGTJmf/XwDtRvHMEtMCv3vGnnAudypiu1
         SdFxfiWbp4DkKVE3xIFy77xSrkP4MDmbwb8+eqC9X+QsRtpObtrobTZE4QLxccznZZjr
         0DwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RnlrKC6yQpr/o0E77FIxd6sNz6VZtPb046x8kNGEgp8=;
        fh=2S92v3zl+vIxQ1DWPxmvxNXeGaNSJmAbcNvG0WebMas=;
        b=B0tXzfHaQhAsTYz/OCe3buJZOqoR/6TxCE+BvjtT3v8F+DcvA+qom3ql5mtJhEuOB/
         K5c2Exs8QydG1hr+Zcv17mq8/ZDV7Kjbckn0e9Ubw8rmssTeDVLAHgkBqXDNvXSIHXXS
         OGXMk7iVV12NT03Z9vqimOy9vuywpo/ljS+OnLZ4yoStiopqbS9uuQoagEQ/zi00K+Zx
         KT5Be+5uhkRSVpDi5xSsTN+G7y4GO82CwnhatF6U2+O435e5zojJAUTk4YEoNF129zGm
         umk1hQJs2f9GfIxsKw1xjOehIPMQeH4m8PU1xXkpZFriNitxd/+ut7HgAwGkD+BVJISF
         W7Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786534753; x=1787139553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RnlrKC6yQpr/o0E77FIxd6sNz6VZtPb046x8kNGEgp8=;
        b=PuXSz90l1EA6Pne1M1DKWrViHAItI5sBfrNBqF3MJQHYIoaMTLvoEgi1Mlx5SW+E6Y
         xqFF9LsacuRMMceahqxDMiScL6azhkRtICTKobmUKACAPwDRf3uQlZS0eAGYnFd4yKD3
         MJsoBwCaM1JM8OpZZoqLLxlTpC02zlk2unollvHIWKnw7K+obVfg2vc4TpLCZMO+5sq+
         gNDLeP48LT6Y1nb18tCYE1HJuzYqziWZfj3elos8aBtknzBY+2piOztTt2L2VyuzlTsr
         1gga7hDg4U84RqD+UYmw08GC7dyp8m/xNl/22fZikLs9yili59jfZnNT5uIqed5Y+1+s
         CNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786534753; x=1787139553;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RnlrKC6yQpr/o0E77FIxd6sNz6VZtPb046x8kNGEgp8=;
        b=APy8bSB3O9VEnCchz59oSh/RKEDzdt35dpBpI64jsCSWrlOhOouZ31uqAY6A7/Mk3F
         3VnKIbSKfdylhIxWx3eKouB/ADUvcoiqCmf0Ohmmik8KfuE0jOBXPySN513TGQeFkUkz
         ZwguDP7KM+eGxnpBfwNbcs34Pbqy0GjVKl0KOsIToS6iuaBInVR27OzS+equSku81VU5
         SWWznnjIPe6KuXsUGCnOMRATWNZyBaQ81HN45HxxsgHM0xml3Ny5H7TH/pZbkVJDWxr+
         wvUZzimGdeOoqwPZAVzU4WH/ppBXN8zmLbh1rwkDUTsaRWrKS+cfW6HF++l1T5Yctrvr
         e1Sg==
X-Forwarded-Encrypted: i=1; AHgh+RoLiBxj5RJD8Omhio4+a94NH8fzHu+mVS4ySaPCtzhd2DLLeTSObvzafkTnRnE+/ljdVrhVK+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ+I8jDf8G3WZSV/LV+/NsVI0Phl4KSbz2uWloTxMxhR3r+/Ky
	05zHLQe3gXgU6vNWJn0rZh2332QOee3ZmqWXTJLgbCE/NwneYRb/IZYA0TUo+aBVCdlZ6CCPHVJ
	d1kLQMiOZznAzBjVeHg99sfJSF8Wn6SfE/cgbzIhW
X-Gm-Gg: AR+sD10OxUsReUp5IcFwnxSglxNmSVynnEND0rJjOEJ3vw0kVPexMAGArx5GtpygY5m
	CRxvbliUGur+R3e9V9crvGYl3WIP6vNAkzo8UGfBGXVWrkw4eYrNfA7BV+YBfAOf2evBhGUgUPH
	rba2LQQdJvsGV1YPOCKBtEmklozb3X0UZMe4us8BpqbJTi8owPesypmePS8PqZ+vQp1UgMUzrdw
	n7kCvavk/7GvKOv8iL+t5v664tHadxC9tfo2mhippEpTDZRFBpJkZyoqpOsQ59ezmKNH7Np+cJ/
	9Xqanfj4KqHFBk6nqLLEGomxAeLEv80vdc1aunA6+lWapNE4kSAbB3q12qAbxjvREE3tRtVUM6n
	uRzx5gTo2QkyuWbVkiCLkl1WP9/xwplFIi5Zhz7jcW3QkUIsY/1jwmcRttkHQil1QNeW/f4cXZ/
	bvNOq3p0XdBpEJ0KaO5g4nv7qL6Q==
X-Received: by 2002:ac8:59c4:0:b0:51b:ee11:e71e with SMTP id
 d75a77b69052e-52d646b8dabmr31842851cf.1.1786534752356; Wed, 12 Aug 2026
 04:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
 <20260807-net-next-mptcp-oooq-pruning-v3-7-dbc1eb853cc3@kernel.org>
In-Reply-To: <20260807-net-next-mptcp-oooq-pruning-v3-7-dbc1eb853cc3@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Aug 2026 13:39:01 +0200
X-Gm-Features: AUfX_mxA46OtJnZFHzG9nKl9iGiktqoxt39eRI-qnZy1K9dxmhi-xoA6rpd0mD4
Message-ID: <CANn89iL-rnJtxVxJEf3j0PX3X8A04vsf-XXQvb-_FyjMBBM5nw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] mptcp: implemented OoO queue pruning
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Gang Yan <yangang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 3:50=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> When moving incoming skbs in the msk receive queue and the latter
> is above limits, prune it as needed quite alike what TCP is doing
> at the subflow level. The main difference relies in the stop condition:
> since MPTCP does not perform collapsing, it's better off dropping the
> bare minimum to fit the (newer) incoming packet.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Tested-by: Gang Yan <yangang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v2:
>  - Uniform the new counter with the other OFO ones.
> v3:
>  - prune only for new data
>  - reorganize the code to follow more closely TCP
> ---

...

> +
> +/* The stack can't drop packets for fallback socket at the msk level, or=
 the
> + * stream will break.
> + */
> +static bool mptcp_can_ingest(const struct sock *sk)
> +{
> +       return unlikely(sk_rmem_alloc_get(sk) <=3D READ_ONCE(sk->sk_rcvbu=
f)) ||
> +                       __mptcp_check_fallback(mptcp_sk(sk));
> +}
> +

This unlikely() seems inverted.
