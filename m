Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C0D3033EC
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122498; cv=pass; b=D4AOO6leHsOD6scEtcxXQxVM5BtSN824ESaNw0R160fmnQmhHSDMW46/CML1kudmJzVdI0ToQwsSnDVhdwuFzHEovTR1HSQP7FA8QyLu87EMNfltch+omVgia6H/3oCJlfmQeiG7hYFp+CyU4eXC2dptWdI3oxhrKVjj0uDHNtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122498; c=relaxed/simple;
	bh=WDhfqi9KVGdv84+1ic9hTc/O7+GDjdOl7MkC6oMvKIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TedqsumIj49rdTUpKYETKwGb3noHkiXqj3nQF7UEoRCCWt7RJIHoGBl1Oxhreae8xRd1b0QRpeHpgNu3WN9/ImN2Gf5kPKWRpp9yXzy93F2LzTGhfcoewEHKyUo+XI03NuCRfl0q+PQ06Ngx9LUSxW9AB6wyxxB6xJzckdfnj0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MFUnJYMq; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MFUnJYMq"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso6353a12.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 20:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792122496; cv=none;
        d=google.com; s=arc-20260327;
        b=NBjwWRy0YWXdoHcB2CJdk+IW2KCehr7nLUvyclfjXhEPQu1x/aUv0Hqea06DXwgOvE
         4RiAvlSVXdsg9tJW6/hA08cZbAsYZ2Kq7gqellVNRaPwWF+LBZXjKMQwWSBLXI27lIit
         ZhZB5NrZut7FeaGxvkS4ExrIL8DWAztx3anKa0IjHDXlZuQwq+HfWRjdawunCoy/NwAw
         AB32L/Vga1gZGycs/z9yda4NuPDlWBIypDOE7KAt2K3vXsoF3ajKDm4na4Onda23fmsc
         Ct4OAbWAY5zK9ClkiIt0sWGPrY7JKn5dVyYTIq8PORODHXCMK/mRywjxofPep6yc8/8e
         uOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cHwmVcL3Ea2QJiHo6JwLvdH2j4OcK78NhenhdrCZCWk=;
        fh=1qiJ3F5uBo3fC5LI1LrOGTcuGDFIRg99y0nYm63EnrE=;
        b=oEWJtoea2dSyAzUke6SWNRwsLroQTkdoUfqbScyCHFely2mQirqj1gc1y+tA65VkUE
         I9bXJIPbaArAfuLhGg0YjdOsuADXpqfRm+WanFgQ6QRHujVemiFVzJTmJcuWBxb5V7aI
         abaDALO+C2tnWD6pDYYGi6vcVuIZhKyIOrc1E98hVzM9rIeCy1de9v1EhXnLhNPvoCfI
         4OYxj4dWgtI66d7JcOQFuFtv8TdyVzfBGR/BIWBB+K/s2remy4oC2GKSouL5e3p9XRLZ
         q4YnRTHwhHxsoFckjwcZaj9LE3hh+03ut/j+EiNPuYJT3ktEUOq79hi3qykLC39EbElt
         6tFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792122496; x=1792727296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cHwmVcL3Ea2QJiHo6JwLvdH2j4OcK78NhenhdrCZCWk=;
        b=MFUnJYMqeRN8pn5oS/fx7Cd7aYGZTuAmL2OPtbvk0h3AtusqHufhUy/9R6we1FzGNn
         bBiaEt0IoROvODwpQgTngVSOBgbPr3GOWyKRzCSfikrMcdUKGd0EziFzmIUG00VCAETh
         GcF95UW2KmEWCHa4jPsDafHok/nbbXBUu5l4cFYA73wuuyQl1nvwkiiyQqZngE4O17V9
         ZTY095u1puHUkVdeCxOdqk+UQTLkUeao3SXccnbw6t2YW6/4qw8Yyc5EHtrT4/gFylU1
         9QHOTqyYD5w+XTG1uqls1Fi7QAXNy3HD7iLDB9Nqi0L0HcPN7mWIcD2UnifQm39korJ+
         dJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122496; x=1792727296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHwmVcL3Ea2QJiHo6JwLvdH2j4OcK78NhenhdrCZCWk=;
        b=JQA9OeYOWp5Gv0+w7oTgF5mKegx65OtvJYq7/fyT80B1p2eJqKkeLJBZPYpCjIHSy1
         6VmsbU7d/lhV70WPCZLzJ1+KKG3gL27nSHrgZcbMr6BEYF/T0cJf+nH1hBiSqhsY/piz
         Cf8wfaY7dI6PmAqbTWPWIJXnZCgGj4hnLw+tkb1Dhm0EHayNWWW1NPZx4/7xofqTlmyT
         qpEj3xpAqkYcHgH2Lxk8BWabXxHLdEZ5mSPzSk11GGcC4+hJbGjxgQgwDJ54tnBG05iZ
         6HEdKjlj+up0CPmJhQ5mZys5Uh5RwueCuriwZQCeNCV4oRA+ey5V2IydDsYIsH+YdVrd
         3N5g==
X-Gm-Message-State: AFq9FYJrgHZoTDziE/E8sNSiaJcgtkOOn5GZh9ThB1zLJ5+PVvWpHOPP
	DllekTO3KJA/0xX4gvLluGYZSqaSunuZjGSF6KI3xzFzJBXCjrkISCq3uj4pLx025Q5EosKs8pK
	4zUIA5IiVjCPV4p2KV9/TXDtyE3Gol+HXTc2JYdRC
X-Gm-Gg: AYBFou3ZeoLhq+P7hgyl5+3wXAc++6IZ8Mo/C4r8jsY2qscEpn1NRvbVeiVP5imw3rM
	YCNf7lOWmD6v4pr5kxqxs7XwBhnyDsizSdpurxXDojlDJww/olXMHdMm69NG1jdTgU3+Nfaiy1m
	ffqRWTQpaKxwpvvX1VTM56gg1sdJu8NGgds8h200KzlbUoX20lavVlMsB4f1mI9yQeuZ1dmA0wu
	Qjj7SPMk5Ao74uZgHN4cP1oLCa70sOw/cj5YwFIvse4OJZCoZMEUfDI4hfGZOQRqelfhVVa4l/N
	lixHimIjIVcUJnDXVQzu26tEb7bCs0eRzRwr6xjCpnjYw/SC8d0v0Q==
X-Received: by 2002:a05:6402:a6c6:20b0:6b1:aa31:a627 with SMTP id
 4fb4d7f45d1cf-6b38ba0dfd0mr16268a12.4.1792122495231; Thu, 15 Oct 2026
 20:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014173945.373295-4-almasrymina@google.com> <179209666051.434549.2929683677785392178@kernel.org>
In-Reply-To: <179209666051.434549.2929683677785392178@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 15 Oct 2026 20:48:03 -0700
X-Gm-Features: AclHuK82vYjG9iaKBiwqWzObGCIoi3MxPyudlxUnlS3qJQCEAcDwsenVdF71kak
Message-ID: <CAHS8izPxoA6fU10fSNzKkZHFrWingOgduWOoD7ywii2058GABQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] net: skbuff: replace skb_page_unref() and
 __skb_frag_unref() with skb_netmem_unref()
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, ayush.sawal@chelsio.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, tariqt@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, ebiggers@kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, petrm@nvidia.com, u.kleine-koenig@baylibre.com, 
	j.raczynski@samsung.com, wang.zhan@smartx.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:37=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] This commit fixes a real refcount imbalance in
>   mlx4_en_complete_rx_desc()=E2=80=A6
> - [Low] The commit message describes the mlx4 RX error-path bug as
>   "underflowing the page refcount".
> - [Low] At this commit, the new kernel-doc in include/linux/skbuff_ref.h
>   names ref-side counterparts that do not match the code.
>

If it's OK with folks I'll just ignore low comments. Even if I
reworded the commit messages, the bot will find some other complaint
about how the commit message is worded I think.

--=20
Thanks,
Mina
