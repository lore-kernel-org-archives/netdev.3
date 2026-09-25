Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0C417BD2
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328554; cv=pass; b=boPGXVvY9dpQBFH1EmlurIAFfLAUW2NLIFePRtZv7qiaYtJgojbu8DsknTeumoPHAUuhwcVXB4uXUYG7HMH16BjNVvo4EjUD602m6GdjAq4XrPhNCPF3JqXKJwFAaxU9D3yIL7H7w0WWv4NZwzxJJiknJ7tlCpsg8ZMaZd5xnBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328554; c=relaxed/simple;
	bh=P13/I1JpiMJObKwvzR85BZx0pPqgNlRep3BwWp/ddK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EN701esz2eKDB3WehDrG0lOMS9t/a/2LainfzRlrDoVC1DLAIUPBvjSGYK4AwPSfceBPO9E81cEoqotPJVPVbNn39r2PSCBEB0zv/WMecuCIbpaBiNZ7log62jKPW01skNYDxhfrgMOPuSp8tkwJ/FaKz6WjqAInxfupoBe1s8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muO3fJR4; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muO3fJR4"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb769ca02so8280221cf.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 02:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790328552; cv=none;
        d=google.com; s=arc-20260327;
        b=daPoSnsHwvgY15LoxMV1QKOLAasWFRKyxJAPeff7ZYBabMcgSBfyPP0P9DW6WXSQYR
         3W/0WIgjGs/uOqGu8YaZm0Sueykv46U+YKZCM2qqnhnVi3qYgmFy24Ynr/jCNirMEBY6
         zyBeXQCU0yWt2+bHUMKmZ1Xct0s+OnxFCv7EU/adm9QtXNjg+Yaipd2RvQqfm1knNCHx
         kfIkuxw7oOgraUQ365qkVqXPFWU36Ir26thc11zQ82NYbTt0f4rXEcFMR0yOJWDKku0D
         9loT623DbCWFXlvHfnFMmlm/DY16VE+0ba5nVZtYQFJJBaSFkiRDblcVlMV/8C1tIWLe
         x7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eHsY3Xqdz/2Bt7R/n8dp++evyHtiGaZ4pzrOna//7ZY=;
        fh=sveDxraWS5Q7rNW4VmKx5GINQI+lLtuO+0Mhu3GgeNQ=;
        b=TNPeUUwP2tj1MjFNQBGouE1V87si+TbrxFI0hEMyL4QkBA87ADGcqJdYZDAYsiSiOd
         U7YM4ZJXydXadw56kQkO20BXTMXvAdNLwrpaipQlHLapL+jvFo18/XHK8pmKpHYbufpg
         1X+xCUqKwHVsfhnEfRil9kAm3s4y4LCJ/QidMBxuZl9cIhpSFe8/qpr4I2kmVzd/9jkQ
         /XJLkS5mQN1x+fsvZIMkdLW1OVKx3E5Ttf6X0YH7zJSwhocX80Ms62lblxktqUj9zufR
         FQXsqBMhXrDZYhysHfolm0Gc8TuIEJs3aAKKxJ0vWpxgogisXyHoyfZMXgasRzU/cu/E
         l2mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790328552; x=1790933352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eHsY3Xqdz/2Bt7R/n8dp++evyHtiGaZ4pzrOna//7ZY=;
        b=muO3fJR4CPBEM/yErlZlqYi8jFWd5INwQiK7uC6mcGR1xEopp0aYKSWFawkGMWTbcy
         iupfOZmNjHxCLz/u5Q00ryK5t5leq2YXIyUwGAJzKZD0Ib8r6Eulk/6sTF11mIr8sku1
         QylrkJuJl82p3BLIC5A7x4z89wYOPHko0mVNMec/ECW50ENRW7TiBNYqyIaV9MbjuBfP
         2bZKDb+DiFDXN7WSPC86jOtkSfRZlzQ6r5YDaYlxvLyc3+Ut2+v3QhSyKzH/UEvjO5Hk
         boKQvtv9YGoIRaGqygbVNSK95A4ZpHS6JnZ2urVhKQh2nTKPktOqjbyX8rIm1sZOMMGF
         KyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790328552; x=1790933352;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eHsY3Xqdz/2Bt7R/n8dp++evyHtiGaZ4pzrOna//7ZY=;
        b=b1F2SiLpFluw89XdjUJr9G74NjJyp9Dlg/xLx21JSsNezcQsOqyuH0PTGbw7KfM3yo
         2IQdlJKFErXY59c/o2t1pxEdNhkYU2poc9P/8eSiPFK+xaTMIdPkCqR5TDau+VcZoLb3
         ruIxzfNoJY7N4Nts0Y/AXj53nUU2E04valR5V/IPv0lbRseGSRDzlO4VH/E1K77HveTG
         EuQ5FSrwvlcDuDGlxJsajczHy+D1kELS59UyQAUB6XxRZnpqcYqEzkwB0Lwuwi7oNhgi
         Vj9WXq5eK9pzR8E1VR+MtP+/MHwM18DMqkDki8xfCcQtrdUvY1Az+989zkpSZf4DIBG3
         0q/Q==
X-Forwarded-Encrypted: i=1; AKwUvByWE0WgpSnTSm8m5crsyJ8k4+9BlSnM4+c5FjIewgZd1c4QcGDiL9Roga4AXp7Mqg5KwNgYUZ4=@vger.kernel.org
X-Gm-Message-State: AFuF++l5yU1WVlciDDHPa8PhW+DH0FEZxlcBlkLGqAp9zDP5Fz4+XHGu
	rvvV562ib8sebr5w7YWlGSuf5IVgcU7i45pOHHeIGpUldVmc1IHFz/VwK7+WBHLYEQJ5ziRkS3K
	Cckphpk3nccKOE6GjMGi46+Mz9obh85cNsNKutJx8
X-Gm-Gg: AYBFou26IThWbZbktaxjJmSoEobszVWAWiT2cmuZKzm7Ve4qNGPDNuOSQtN+6or/ZxJ
	eBV7NsPgFjXKEnsdFW4O2zGMMjDk9YmrVyRq9D4t9vNt8ClXRK5VAVCTg63ROGvIlUra9EAkUiy
	hAOxBefHjhfBzJxK3gWWKbl4wVHKFQSbxrk1pCO7JHuTG4ueTZkYAHxlOPt6XiHsBQdZHXWaI/2
	eljvAICLmuIJSSBpOIa6J/nh54dSU3Eyu6AhSTWGbHf2OK5C77R95vacMgXlFILnMzrN5hd50Q8
	nrMP+/sUfZZJtE/e1cgNYfXKfdfum3Buihl8SKtjSvIUXMgQbEnZYhvbZUnTdzhsEvMSiWayLIl
	O6nEEOxLY+c/9+ZgBtNdszemDN7rtj1WXI2G2wsw27lE82CnBOYc3jYrywuXWb6/bBX+j
X-Received: by 2002:a05:622a:1906:b0:532:d1db:3ef7 with SMTP id
 d75a77b69052e-5330b5efd59mr32294071cf.21.1790328551395; Fri, 25 Sep 2026
 02:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923035217.179102-4-edumazet@google.com> <179031918107.2160803.12336993632886364252@kernel.org>
In-Reply-To: <179031918107.2160803.12336993632886364252@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 11:28:59 +0200
X-Gm-Features: AclHuK9IGAC4oHL37cIUGx2H61DdhXpccW35tf1OoLmck98goTF0bm8oU7j4KKI
Message-ID: <CANn89iKk9N2j0wLBzT-uDx4fgh6ziS2rLPRcXBhyt=m=+pyJcw@mail.gmail.com>
Subject: Re: [PATCH net v3 3/5] ip_gre: compute tunnel lengths absolutely
 instead of by delta
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	u9012063@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:53=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] When the GRE header length changes, ipgre_link_update() now
>   replaces the user-configured dev->mtu with the default computed by=E2=
=80=A6

Agreed. v4 shifts dev->mtu by the header length difference again,
now computed against the tunnel->hlen sampled on entry, and drops
ip_tunnel_refresh_lengths().


> - [Medium] A changelink that publishes a new header length but carries an
>   IFLA_MTU that do_setlink() later rejects leaves the tunnel with the=E2=
=80=A6

v4 shifts the MTU even when IFLA_MTU is present.

>
> Pre-existing issues:
> - [Medium] Sibling changelink handlers publish a new encap_hlen through
>   ip_tunnel_encap_setup() but never recompute dev->mtu or=E2=80=A6
>

erspan is fixed by patch 4. ipip and sit are not touched by this
series, see my reply to patch 1: this can be handled separately.
