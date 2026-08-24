Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FDE41D643
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576109; cv=pass; b=l0fKmFNN0G11SPOkartIDEnz+Qpj3FO6yOxZ+mherDMd6dIo4Omr5MaCybNouyPXL4e8ofYd8LbRSck/HlnIQQ9IKi8nMSggWqtnBj3bm6CcTaIiKUUiju93HMgtT/HZoRivFmkuDJ7KLDI5UAhAlpsEh3u5IdsJUMz7vmAhbA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576109; c=relaxed/simple;
	bh=lgz4iLkiJBPp4uyU/6zmE+ajDoKM+UwuA4aOSdn7tAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApaW7WS4nU8tH679TKW2lefmjJtjh5VjxWyM2cV8SGtCxG8AMUj5vrHQeQIGbfVjFkepPaUsYAzVZFf7n6lEBqtAooAys2Vno++YT6Q3k25eqlq3SdrH5DW4csM/3UqR6pyIZVd/tfHiYYsLvWqxiT6E8uMD+O2TQK2YjjC7b7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du53TKOL; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du53TKOL"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cace91f112so39346065ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 05:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787576108; cv=none;
        d=google.com; s=arc-20260327;
        b=mmY6qLx7eRCFBViqmeMeKU+vWhxNKNWUr8jgozd3du36zw09gNBPa8nj7J7Ut5LOIf
         Ui9y7ESjHLgqPeSQRmzciGVVXIj/yIZGtmoHFObXGw+ScL/ZC5oUgxCRBJpH+NJ/zkYu
         N/QONdfomrMsRLY7u8qKPSmHLZiDOJcj02/ztkgCZwu/qJCk1iJw/+iVcLHMZBbVSbii
         zjcMp3oz743o/ppNywyCe6noCXf08vcYZ3hsw4iWkVczBfoJE8G1yN1m+PRCKInOmrbn
         EBulUp/8zp4P8BC0ZdLcsuHtjZx5JUwzrdIABnIBQJZs47l3jWkQ1gXklFZeF59wumBU
         7imQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lgz4iLkiJBPp4uyU/6zmE+ajDoKM+UwuA4aOSdn7tAM=;
        fh=Cu5cmDHAuPNuZpJrQyyMlKTTilqpFrGM3qa81oBJpBE=;
        b=HZCbes7kK24jM2LB2n1dkUoaL9iyPRiGfhjNMSIokAYMZvDTV6U6kNaxSj6ZZOfq5L
         l8dzoEg/OgaycSu9KUzVt56ViVTapVmBMU/xBsqtV50ETFFs3/0vmjg5aIuhvHwxrF09
         v9PkOp5ZeNzOWGkmulUCI7F3I+UVx44e0MRCi8uUUmga/yWLhrufgK981PdAPbekY7OF
         6KsEVGKu4KTBODq6khvzvv2wQr9q6zOhYAoicTdWA9vTxXa8o36JvPqYGEb2pU1t9gj3
         7JgVhY1RkRIpZ5A+iJzp7TlJa8jBDp6OqWZ03gEu8P5rKtaznt5dTIvDvyLzu68sCto+
         jpUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576108; x=1788180908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lgz4iLkiJBPp4uyU/6zmE+ajDoKM+UwuA4aOSdn7tAM=;
        b=du53TKOLRdYUrCRh/nV23jQpToKBze2845bXYf3X+40LZn8rHy5csgffgUqc/3JdvO
         ckS+6hoW/lLYmhn32VLTw2AzW9j7lHVnOppS7YH0RsQ4OzZcErqItVA5UIsKMVZvlRtn
         Yls2mY6D2jCxIxrOHzV7otfgBLp6/+lAR9qnQBoKUBZuAE20dfu4iAQjbWQO5OHS4Sbv
         sNvHgNBLootJB0QiA9b5VZ2qwDIHX21gIoqVoVRySLkgMBXJJI/e1J1/in7u+XjwHmzW
         K3iLTGEM+H6G5aMm+khJRjPosYM9ZUeX9Z58aWH1an+5yJEDGzB/UxgJwnEm/USTd3vf
         +pWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576108; x=1788180908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lgz4iLkiJBPp4uyU/6zmE+ajDoKM+UwuA4aOSdn7tAM=;
        b=hyKwSB92sD/VnccH91+ubj+/gtk5/fiD18CsWVsJLQ2er3e3VhFXxXlE7nbQww1VSP
         oYrnaSO7uZ9Hz72l0AqKXnSUhIytuJAMY+LRexsgto5UOwd2vn3miuKD4Wepb2wAIfzC
         k9fJrJy95Vnihbw0Q/bw/wv1bXyqFsA8D9Uz/c+XWnr9/fJEm8hkkwBLbVQmQtvNW1Vk
         VWiddw1rKtF2b5aH+9x0dj1QRN9p0LQ0H4g8VuZSi8NLwRUztXgKvzRDtZqSZ9/fMQbT
         fA3CbpdTT6ISITF/UnNrIDWZZio1STaiwHMTra/J3mystcl78tjyXXvoTzKQPMuFSxs0
         VQXQ==
X-Forwarded-Encrypted: i=1; AHgh+RpoYGc1xKMwZI+7q2Uz9bfmpzuETXVZTLCMJHUHZ0k2JAPACaw0jnXvJz7D22Is0jadIFdmDME=@vger.kernel.org
X-Gm-Message-State: AFuF++m7pb3O5WCVXc/3xT9bJHrLTdBom8+TfpP6phpLf2MAGdn16qT4
	Z5KsEdBu9ypteksFOR+oGrKv/vJQRTtocaTGSk16DFiMQJ2KEGhZbhar4oIXMdlyZV5c3UPfQIu
	Mm91XMlKvSXgpTx7XzyIoMg9q3Mysz8979fRnxy0=
X-Gm-Gg: AR+sD127tSx/rkYfbk4mZ6ebaBIpsEXt1Accx61dKiyRBHLFZZRmBOtIaJKPHn1SBKR
	vQACsV9KeVCagWvPaLE0sTiJFEadd8a+tYqbInJCKJ8WMlB/zCvCXu1sc1kFmqrPFKSIzyp3ehH
	fLNCPjUhvwERaeSsHBTzYqqmDZySdSO61pHr3EZx35poUh2wo1ej+B6p0dMnvSrcIHiEivhyaf5
	QbokeghNRopXXxjwCOj1JnMNoPHcITBOGR6wej+ei/8Hl++qMKndCylbR797UsdOYWZ8f6sLjHm
	AUQJncmg3vBilUaMkJPXmIQFaXxB8NfI1NcGMZIIHuC3AA+igVB59Fv9xMFYFyK0LdD4FpP8FmA
	FkJjyTNwFZ6AnYBJdw0iGVNkUDbMwbQbF8ETwTu7CwgCJCs51OGgECs233H94
X-Received: by 2002:a17:902:e952:b0:2ca:ec6f:aeca with SMTP id
 d9443c01a7336-2d670bf937fmr359180455ad.8.1787576107820; Mon, 24 Aug 2026
 05:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820-b4-fix-pcs-lynx-an-v1-1-62d66391eaff@gmail.com> <xjhcgn2ki6a4vlmo5cbn4oagw3jyn6zkomjcva5w7gnugzbloy@odub7owqu5pa>
In-Reply-To: <xjhcgn2ki6a4vlmo5cbn4oagw3jyn6zkomjcva5w7gnugzbloy@odub7owqu5pa>
From: Patryk Biel <pbiel7@gmail.com>
Date: Mon, 24 Aug 2026 14:54:54 +0200
X-Gm-Features: AcwNN1XflYeJcTaXVVQUcRzJq3YNqFy3_3ybSXYnpr0dIDekUgQP5v76mVqRz4M
Message-ID: <CA+DkFDZzFLHxgBv5Z260gwk4UbYAONxtTewFHPV2vV2M6z0Q+g@mail.gmail.com>
Subject: Re: [PATCH] net: pcs: enable autonegotiation for 10g-usxgmii
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
pt., 21 sie 2026 o 12:00 Ioana Ciornei <ioana.ciornei@nxp.com> napisa=C5=82=
(a):

> For v2 please explicitly target the net tree by changing the subject
> prefix to "PATCH net ".

Applied all requested changes, however, according to this suggestion
("PATCH net") I also rebased my changes and changed target to net
instead of net-next, and I now see that on patchwork one check is
failing, namely "netdev/fixes_present". May I ask how I should proceed
with this - should I add a Fixes tag, or change the base back to
net-next?

Best regards
Patryk
