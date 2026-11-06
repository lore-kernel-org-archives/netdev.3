Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977344;
	b=1zwGQqedegI787P+/2I98FW6LUdag/UIHXRj3pXuBdgSmdwpcVTofdVkd6Kdbk4wxpVQ
	 KeJgN78p335plBMnor0mEmQ5EOhVIPOpdJ8cbObePU62IhKzU+ew9/U/dud3pNaceYouC
	 SsaeFTqyA9vP5eCqiV5ETO0qYfC7fKIeqYi+kjr7gHnu5ZM8+ISbLIzHLunUIUILYPmNL
	 jcpNR7S2HJ4/P+XEcEEE7wQgr7wiD6Bmr8RqLeJzOV0uVa+TkGu/qk9nSH3+Ezkie6dbl
	 ZnNqV+jKquaCoX8bLJdRLFpOHVzxjwFB4qtzpO0cQzZ1Tqy64mOIXVwHzDYu26wh+Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=7TtPrQ9Bg1ashGXbzDbz4fIf6+H9qB3vHmh8Bznvg68=;
	b=TDQ9mwwi3CruTnZ3mQCcdzbj1S8kBbu8xP/MyLZgq3r+BrDPRIyfPPGPf/uYLbcHq00g
	 3oO84LjYPZtAS/CH8bxFcgBo3azUZh3rhbPo45S2Sug02WncQeSRvsLsAHLjhG+hgTf9Q
	 FPQn96h9qysm0VdeKQIEq1XNBh0VHZ5e1NGdezFSh/SnRNIDyGaEC2uZnlk4DkwY/najR
	 Eyn0t/ryqy8Hx2IJZsrsgufVqbiauOA2Ae6KwyPuy0qCni0GG/wdaghMt/omCJ8jFqkhW
	 5y3x8jtLPcxDCqZAzrgG5pYvxwlskHWXkqJnLk2bTmF7nf3G3C61gb2MT/7vbIzSciw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v3d3LxOm;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27EB606D801
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 15:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E27EB606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v3d3LxOm
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c45551fa84eso106000866b.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 07:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793977342; x=1794582142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7TtPrQ9Bg1ashGXbzDbz4fIf6+H9qB3vHmh8Bznvg68=;
        b=v3d3LxOmbmLV3oeMndwwf0G59Th727hprEWpBhAUqDprLmS3KRhbvWYnoEHI1vfmrM
         heNUOx83bERl4AumWpLD7S3dtqq+u5u+//2azM2w/GtZn4XURumfF8Txp/RBiE/VsnPM
         fK8Mc1j6UrRA5SdY29JSqrgwy+3nASoNFmU/mWMxt/2QRprqEbkAiRqL/+ldxwZU82rD
         rDJk4QHukdvkVgJkij9xHYF1HxCm2/uD1eBzk+wJYPyO/fcMYnIHCifDimeYlfm0FW8J
         KcApHVZga08igvrgIqpsIKMAQPvPrHn3UPbxk2mgTzy+Kd69/rfB6YnM9qOc2zTcJmld
         99yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977342; x=1794582142;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7TtPrQ9Bg1ashGXbzDbz4fIf6+H9qB3vHmh8Bznvg68=;
        b=qBiM9hmtD30EO6UC1Q6FLnIrGJpCp9/VQYsDclmD4Z4XAfhuSLO695UmCYI5HSk9FI
         gwKYFbDK6eWH1eBfj5mZn2W7xmE0z3oD9GLzRC+sGTHJPOv5VLm8mNNl79k3VLa7HjJ9
         HcEsPOtURBaIIYn/rBMvXDnvin2z+v2HvHq8L90hj6hVAqrHqu+jIbIBxkiPFbEb3Q6n
         Zw9PuuNiv28kwU4I3/X92Y87NidJlj3MoQirb7RRA76GleA7n+F8Hsg8UYB2Jn+TuJew
         88gyjkX9DimNScU7R81hcwhZLEgYdkBBopy1BntIFgo9ij+LkhJ6Ch9WNBxabM/Lz9rl
         Gi/Q==
X-Gm-Message-State: APuU4Z8KgYAV9Riuv3QUAH+wmm9UjmcEtaPmQrjQNwYuxC13PvFo8M9I
	EUFqvRv+K7LPyxRm7f4R907jKhM8MDj19TZNojSP6hoBmU2ng82uHc9Z
X-Gm-Gg: AYBFou30LEoY+b7AYy2Ktqxn2qxCkvIM1fCu8zI5ts+HWKFzgNuP4YuzARO+pEvw3mr
	f45eOIbMRGgOAfnBwZCxsUTYnoFNF/cAHYKXKTH4DThEAgWJPBs0iRR7xUgvDbFrI4WE0H8AUmM
	YrBa8MWz6HOIrdWv6uxzA3E7CQ/cc/kkLaZkjJSn4rmQviyWGNcHajPFFeR2nZ1ewbMgcTQA5B+
	4j5eLI98Vh4934cEyCvnUUmEy4haLgrRIKQ4/JK6U9779VCcnYs4mijNXJlxKHvBW3xBSk500oy
	7bsvLQ/TKNWAP5sdXh5GEXoK0cESlyGot4OE6nlkmFZNJTrMAkEK7ppC163nwb/pB9jmjG7fktX
	vMTsRWezL4RPZ7pmvgUiK6/kgSVsNkrOUJN69UH0lNOFcSRYYdvyGSBjH51McFIj4Vgc6IR0VhN
	mM8Ts71H+SrZHZE6LjvpkJxHjMHzkDpn7pQpfxFHBhOH8ww2dRKtR7D/+ggEolUBoS+KRFgO5WE
	f6DJ+1Gla+GyHIuE5jE0kk6wC2oisV5RD8Ts/NsN4dzSf4BtMyChGDOt7wvU6pTFTIr29yRhOAi
	L0QAg1LzHa0cI7UIl7PR/Rm07ovHFrL4gi8ugxCJ4hzkoMH1JrV71yV5Pxo+XvHQuCcFklrRcsc
	XJQSLH3O+GPlp7pxnAZQUe65rrt/l2xAV2Ypjz060tSwyJUP2MfX/idJ+41zZsxbpjRL6AsWlr/
	z/
X-Received: by 2002:a05:6938:a013:10b0:c3f:dce3:20d5 with SMTP id a640c23a62f3a-c4d354e39c4mr186808566b.22.1793977342099;
        Fri, 06 Nov 2026 07:02:22 -0800 (PST)
Received: from desktop.home.arpa (2a02-1810-1e16-ac80-898e-1938-27eb-b890.ip6.access.telenet.be. [2a02:1810:1e16:ac80:898e:1938:27eb:b890])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664aff32dsm873989a12.25.2026.11.06.07.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:02:15 -0800 (PST)
From: Stijn Cleynhens <stijncleynhens@gmail.com>
To: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: netdev@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: realtek: rtl8365mb: keep the neutral PVID in VLAN-unaware bridges
Date: Fri,  6 Nov 2026 16:02:09 +0100
Message-ID: <20261106150209.3659653-1-stijncleynhens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <autRCms7HolT2-au@analog.com>
References: <autRCms7HolT2-au@analog.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 04, 2026 at 04:57:44PM +0100, Alvin Šipraga wrote:
> This part threw me off a bit. What do you mean by "VID of the bridge
> entries"? If the neutral PVID is programmed on the port of a
> VLAN-unaware bridge, I would expect all untagged frames to be classified
> VID=0. And with IVL this should be classified local to the bridge. Is
> that what you want to say, or am I missing something?

Yes, that is what I meant: untagged frames go to VID 0, the VID that DSA
uses for the FDB and MDB entries of a VLAN-unaware bridge. One detail:
it is the per-bridge EFID that keeps the lookup local to the bridge; IVL
makes the VID part of the key. I reworded it in v2.

> Please separate the variables on their own lines.
> I think an else { pvid = 0; } would be more explicit than setting it
> upstairs, but it's a nitpick.

Both done in v2.

> Can we unify _set and _clear somehow? The code gets quite confusing with
> the two variants, and it seems now that with the vlan_filtering
> argument, you can unify the logic.

Agreed. v2 replaces both with rtl8365mb_vlan_pvid_port_commit(), which
takes the target VID (0 for the neutral PVID) and the filtering state,
and is the only place that sets the frame filter, so
rtl8365mb_port_vlan_filtering() no longer touches it. Tested again on an
RTL8367S and an RTL8367S-VB.

Thanks for the review,
Stijn
