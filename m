Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED34CA797
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767391; cv=pass; b=DA8yI58oO/vpZuG/825bvsBuTw0BC7mxmczQjoHb57SmR5aq7yQcJkENA5bXj8c82hZJBScrIUSc/PYEGR5v2ohkNBtUJ5DA2leXZPwSjukEBzF8ZGaFDY1AvF52zsuim6vSPrFyhB35ryBdUnOFM1Mff2o7Eep1q8+KlDwlfGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767391; c=relaxed/simple;
	bh=ElwHOsNcwB45oWoqXfNC0o2cm25sKcOriVju/dXKb44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xqe1BWSUKAgIpLv+8IwRDdgbWweCH03E7UICz+Zidp+qTKTymKaCModBKgmZVARJk4kyvx1XTIoCLg+zzdxQEJywOBY3L8vfz6MQ1krBAstSrsBJXslcQHMKs5GavQOLZLIdf29njMXhxK+ns8PGYnH6wsLFefQBuJVOT8LTnOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3N9u3Nm; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3N9u3Nm"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-53320068d8eso48761831cf.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790767388; cv=none;
        d=google.com; s=arc-20260327;
        b=bZfspTp6wOC/S6/9lzDExaMXxVzyXE3+fcYlm4VAGWaIv2E1rGweYtWumqkXEIkCsX
         FljDj4Menqk/3dZrOm3pIrCdT8SuQzdK0hLtIoZUlLe91oY6XrcIjP/PqySPSHLQc9NK
         B5utU65S/KjqBXusjzUXGklXvObLrmNj0FXcujDW/DrIU15xppgKD5uD3VOyc5A2VLw7
         fvDWeINwKu+mYo6Mg6ZyfhL17cIWIWWg/4sFxejd3Nn1XtITR5US4Z4Zx6nF9eSxHaqS
         dshUTx6JYyw7geEMWwdCjPQsylKkC/LTMae0Cer2/ldNzsXJSTTUpJ6Kc9LMf01HKsdW
         Yd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ElwHOsNcwB45oWoqXfNC0o2cm25sKcOriVju/dXKb44=;
        fh=40mHkL57EZMdeqTU+P0ACfPleR8GBvgqJYwNcUbN//I=;
        b=Zo+2aTDR149ZKBKloDwf7y0qIAtLrAhK5EU8vnKO7CySe6t+xAFzlklRRixA8julJw
         6a/dh48qAo4/TdKRILiaSz/lQL4KIsMXZpXA1tOEJyTS2tkfNxzdlPZwDI8D/Av/PYti
         qiMLMtoA11Bw64A+7ssEr5UWTZkWO1kRzTCd1coswbrXXisejzPoeCY2sRl5navVuOC9
         kJLKfQcXKPqwWL7dJXx3W998ngcm8krXDvhOqvAWernX33M+PKGhq/S9AeUigQHuCxGM
         AZbLkPRXMrnW6HvUiSlSRYKGVg7G5iVqtdYoHzQE0F8wB+VZsJ7WbVpTtSPnsjPmlFqS
         lCCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790767388; x=1791372188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ElwHOsNcwB45oWoqXfNC0o2cm25sKcOriVju/dXKb44=;
        b=A3N9u3Nmpsqwki5My6pIKweIWQVdWd087ScRmPPLkuTE9iJ4hbE7O5b4zR9pPAilcy
         DMiUnU/lwAQgW4EU8ojnLkpmh49Cc+i/YGjPrT3LFIV5nf2ksVA9MrbLJjnKMeMwUprL
         82o98kTRrORTkXidTQjxFU8tCrd/ORBfxcWfddWEk50+PyJro1ABQyM5Zlvb07vX9Rme
         L+7KZWXesVLw5wxVn8w1rByG1Re1NDjy2ESYRuBwJzEzb+GW2Kq9OeoFrazgcy6p15xW
         Kj2QkTxYQPanwVrnVhiKfSoUdjTJ/bGlwlWJWw8XCWu0q+3LoB4l6KS4MpJX/XllJB/o
         u77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790767388; x=1791372188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ElwHOsNcwB45oWoqXfNC0o2cm25sKcOriVju/dXKb44=;
        b=cB2sNk7BltFrv6zP9BZu7BQ7hh/uJLqMPbYURqWx99F5XAC3iAb8uxVWBXVy/tJQxm
         BmQlwFKqzQKQZeJf3HvEvAYPLA+GB9ux0gHO9CCSDlMMr3Uhn6dzX8Yue2dQuQRc5A9Q
         kf+Rohanl5wKriO+21U7lv07hCecIAXH5uvsi6hEqdulYHW8P4/Y5TrBq/c5HZNbnY+N
         +SkQdzGkqlouFV0sdT81GPBNP1z0JVaThD2j+IqDCfBTCo+8lvPg7FMeSGGmLbrv5FvQ
         LNrU26mdSHrici4QBWdwmojFSxhWZppHxZ1NuzCco66tjCyS9rIHOWheiDkzRsmbeAo3
         qDug==
X-Gm-Message-State: AFuF++mjjyroyXZUNTVU3eADhQP758rCn/WE+kQM379yEdjjzXkL2orx
	wqK8l3EMIw0LDxFBYduTYRQDU6OpWKV0xDFPkxAKNnSwJkkJbB1fOftlHAQM7mLP7Lq9PyW1hcq
	9ucg6lM7KN+FegxU/egobh+AA6zJQ/oTOtklLb4HD3wMQxHlCU6zgo9nc
X-Gm-Gg: AYBFou03QnGWKOB+zy3u6RdbMbvir1TvR4EtFzM6HpPGcm2yd9KLtxz2U1RzM1afrY/
	lxvTMHALSxOyOc6LC0AxmbJJgojMwEJbjaRcyt8AyqZdbu4l2JRWBFi8a71YjwHv4ie17r6JWZH
	T8R+83BK85oh6t8LiQrqlTIumcbAg94FxeB/KhPCmLNbYmeFcvoagow0XizhdWEkCaTKoTtvKfh
	y3gV3kYGo+5B25HGqLcRUgfjjM8V2uPgjKkaQY9Hw+sSKrWBehe+kHtabs7prunNxpP/1wkEjaR
	bgrIHpUKCVXUUZM21ZvAUZ3Zs1caeftr777rfXeoWJb4EhqZPdS9SGZpDjba2ZYBm+n7NlsOyHd
	FAEXuYsiW9QweZPGn9mwHwokZTUimzmw8WxPx9cxmv01g1uPq/o/bMWmWZzIuiKm2UtPcZA==
X-Received: by 2002:a05:622a:985:b0:533:2f98:5b88 with SMTP id
 d75a77b69052e-53374486cd4mr18747241cf.47.1790767387434; Wed, 30 Sep 2026
 04:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930100937.206377-1-jiayuan.chen@linux.dev> <20260930100937.206377-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260930100937.206377-2-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Sep 2026 13:22:55 +0200
X-Gm-Features: AclHuK9iE5smdUIZek35Un6MFlxcK_vBsG0IniGW9BaVsFvbFSgOUVfq9WTNkRQ
Message-ID: <CANn89iLJ0Ao6csvTJgkJVWP9Xhgpa+j33-c-2smz4tcnBu+=dw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] tcp_bic: fix divide by zero on max_increment
 == 0
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, VEGA <vega@nebusec.ai>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 12:10=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> max_increment is how many packets cwnd can grow per RTT, so 0 makes
> no sense, and bictcp_update() divides by it.
>
> Reject values below 1 when the parameter is written.
>
> Fixes: 83803034f423 ("[TCP]: Add TCP BIC congestion control module.")
> Reported-by: VEGA <vega@nebusec.ai>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
