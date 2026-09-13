Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B42F8E98
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789318826; cv=none; b=rkmh96oousWMALCxRXjpL88GNBNSpHYLq6MY/+KjB1hUAxaUk0et9KhhFApbvlbUv/Sx1m7cRE4/+8nSUZc6ZdScVK9HnoeJRchdMSsgfVK0Twf/AjlJ74wJBqJdF8pBKGxKWtHY72nOwJSK+1eOHejKz2oKT6EE3DA8dPqBsm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789318826; c=relaxed/simple;
	bh=Qij5oXZ+lK/gLxu+gpobAPxEs95iLxbZt6BrkiZVH5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPFmI7YG8xGMEfhUyFyfy3QrAl5xoxkC8ZAIlfBkp8uHabMvHGxQBX3xs/CGNEyzx8saxQ8LQ1YzqJeXc5ybAYfYvIX2UFtuSZidCC6iGroN+Ucvp74X4jEeAx9m4gkOkd0SDHtDNaEreWDNcGn6C9lSMezBSaq/9Ywd+r+1X4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=XtaXCeL+; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=uu4b0KtL; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="XtaXCeL+";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="uu4b0KtL"
DKIM-Signature: a=rsa-sha256; b=XtaXCeL+g+bCgFbDanjoTouxcoFDQ2fQ97zvZ1ztCfHMn/He4n9kfXQkfsiGoTydzIZtNcEpkZ6Yy/xHo6HeogVAQtdgOSl72qFkuU0qByt4/EMT0CXrfSkDaTyWe2oMSvcIXWqTNxqJ4OsbKLUqtClCwE+A0evYlkRdW+bmTgdXsVg6f0chU+J9euuQf1NMr54hYmWhWzaP02q5ghtLzsB/1eT2537jl9qPnU0FUaC9Lo6RWVgrgG8IaZNri1m8clrQyyCsdl3YfkR7XxR/C+OM2YPofzK2EP7n4pn0rRMEYeTD1C3bAri1VPR99UQSQLAzPgSwnlXWvaqenOz1ig==; s=purelymail1; d=tinyisr.com; v=1; bh=Qij5oXZ+lK/gLxu+gpobAPxEs95iLxbZt6BrkiZVH5M=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=uu4b0KtLaNp9b6huvwB2TyI/7l79OQ7uc8J9IajwCk6PviW8HcgiPzRCVCWYWJ20bLZi8t+4T7jjvMl3EGlpVZGckYk9BX5aXNU1JKTWRkB4OIbnOaaIyYUb04v9uTo2p/7CJTGrZEOUUaloYbUPIvswJuWW82It2e7102JemxuEed7bel6AYaNKD4TsR6RbrtxxOVQOQxJV9b1u/oFeUKHyuNJErjqvpKSAvuov3DxKoBQrV6lcK3Hf0F2YVKlfwoX1oaa+w2bTGfbb/jsmxAi0DWEXCpRNt/VsHDOnD6gFgNcI8Jh7WDzb7SX1EYQUVG0Zj9+Y8cbp6O807vNjOw==; s=purelymail1; d=purelymail.com; v=1; bh=Qij5oXZ+lK/gLxu+gpobAPxEs95iLxbZt6BrkiZVH5M=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -734614607;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 13 Sep 2026 17:00:21 +0000 (UTC)
Date: Sun, 13 Sep 2026 19:59:22 +0300
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com, 
	andrew@lunn.ch
Subject: Re: [PATCH net-next v1 5/6] net: dsa: tag: mt7628: add VLAN
 awareness support
Message-ID: <aqbUU9n7sLI7jKX3@archlinux>
References: <20260906171625.533915-6-joey@tinyisr.com>
 <178899944890.219967.14085595993296385536@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <178899944890.219967.14085595993296385536@kernel.org>
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On Thu, Sep 10, 2026 at 12:17:28AM +0000, netdev-bot+sashiko@kernel.org wro=
te:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 3 =C2=B7 Medium: 2 =C2=B7 Low: 0
>=20
> - [High] mt7628_tag_xmit() (net/dsa/tag_mt7628.c:49-58) overwrites the
>   two bytes at dsa_etype_header_pos_tx(skb) (skb->data + 2*ETH_ALEN)=E2=
=80=A6
> - [High] For a port under a VLAN-aware (filtering) bridge,
>   mt7628_tag_xmit() only takes the new "modify TPID in place" path when=
=E2=80=A6
> - [High] mt7628_tag_xmit() (net/dsa/tag_mt7628.c:49-50) passes the result
>   of dsa_port_bridge_dev_get(dp) straight into br_vlan_enabled(), which=
=E2=80=A6
> - [Medium] Both new code paths hardcode ETH_P_8021Q.
> - [Medium] mt7628_tag_rcv() (net/dsa/tag_mt7628.c:115-116) re-inserts the
>   switch-inserted VLAN tag as a hwaccel tag for every non-tag_8021q VID,=
=E2=80=A6
>=20
> [...]

Hi, thank you for the review. I was able to reproduce some of these
bugs. I will investigate the remaining ones and submit a fixed patchset.
Thanks,
Joris
