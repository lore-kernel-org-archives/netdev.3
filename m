Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6963546EE
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786924839; cv=none; b=giU8Zl1lWcA5cItqkmgyrj9wHi4fixNUp+gxwxnnSN4ib8V8iXSrmOpTGWg76z0olD3NDARg2n6Yj+F7RKkzzzGkB9kvJBGyJ6VdhpG7stzs4/qVDoOt3KguoVH1owLvneuP3DsRGsXorY9qt9JX6R+KWG1qq09TIKjVw9rm5q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786924839; c=relaxed/simple;
	bh=R4LaImY/2T66WrlPaQnoTaMqE3LDAYsVdXsxUsoQMts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZzZC0hazilTPayZ1054dB4+I4D/nM284LWupfPS8BAh1aVaOTKU9dDAbTKyzJGp6neXMFtunD7cI7IFeL1itt9kusGrhRRDuG8nZTY0S8GwPeWVUzkElfV+UDbx73eJuEzS3HcT4AFDO6ZGpZsim54XN3qpiix1pDf+eMTRWrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3CPhCiX; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3CPhCiX"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-448cf99c133so2961935fac.1
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786924836; x=1787529636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NGDW8YHqJRyxuOShb3YiQbckQHmyOYQ8jIzHmdrCgnM=;
        b=r3CPhCiXXkR0suOT1mSnrs188I3B2ZXVUdkNH+syl4ysJ61KamnbTLe/lqpGDOSrqP
         4i+8NVL4+EuFDqX9wYCv7A6HzixdbmLWEIqugcJrSR/L0pAvjOleyECmziaznfCrc1HT
         C/SFEHO3w0VpS8lxHGk6OtQCt1wQsnbfWsYhc5Mkq5AA6AwyZwMObaASnl//3o+2N2O/
         IaYL4TgcXqutHPJYfnrUkNF12/12eIJ9ev7Zo8xddB6N/bgT/KBaCimdwTQ3F950Bckb
         BvjPIPo+IthecXfZJEeDSaclTamHU7ak68F9+Jvy08AEwUiz1k+BA48ZxJXq2qV+i3dy
         pQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786924836; x=1787529636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NGDW8YHqJRyxuOShb3YiQbckQHmyOYQ8jIzHmdrCgnM=;
        b=pMZ8DmEbLwepiK6YJQ8t4/vcEJO0JsmoCRgAuM0uk8l8p9LAY4Nol4QfxWjknkPLkc
         8O9iFMVYTQz3mEMY/3+OD4QjQr1wuy3YVpTA5nDexOYMA+tHvWfTYMMXkOdPIm9K2q6q
         Mf9QvmgtVeMf/mdUyrQee2H4csXvUyuNv514KAQDMGxk3GO8KEgcDD5ZP9qGiDJD8E0b
         vVZKGRQG90obVDTeWGkhHAPZkV4BBNU4VlBCc++CFrlbvaNWNmtq9OjSboVwxaCfuv01
         kqdVQLf76HiDYGs5ZMF8h02OCN3SWiMoYX0vj9m1FSrozGl7ra+3bXXI8Fk7yku2K/0B
         T5qQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9Iyza5Vy6Br0GNI/2xwQfR1M5qPnJDm3UntcWw1kp/3ovrcRvqztxO80k69Odaug0lCCXyR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdeYrpSGkdVkAGys+MrtW4g6mKg0vDyIvhNt0ZbjRiNsb9PncS
	aaOXVTWqAjVdjD+XAkgwJYuHq+mGQ6IWimKkiLGGXShhYM20CeWkXi7M
X-Gm-Gg: AR+sD10o46G1LyI7lHgk1DLDytazMw1GloDT9AaxuOp1Op0aNRz77Ee+rGL73Ew0gaX
	n0BKbxkzWU9i3jzpVYT//8hLh8U+yp8xiweBmyqAf058FuOPZcgf32/Wk94jQlL1P517f2PCc9r
	3LjJHhJZzwiJyYzy4HtjXI/tM7mACMM1OCd4NNv2St/uTDZ+pm0aCAaim7xbWQx7Vpq0leDvp1s
	8Z3zNfNo8m/Lk7eiEG78eOwAeR+R4Qzr2mrugy7o8uNSzMh/2KEPZ3ZAehpmOACvnDKPceCqf75
	DBuuhuY7BlJ/C/iVYBEVvRfGZYLGvarXsKcXWhsPY6SQsf3x3Rw3WdsGhvhm9tfkA854y9smjIZ
	j1fUaSAF1nx9KMhZCRpGREQ0jsRf9f9VRCGJ4IbJcLL3COD8/lImcFf17AMOnbpjxMy8YLEkESC
	odgXb8N4ox/EJEIu6DznHu+mj6aZPiLmiDkWW02vJq8CtVIfXevgVBWFMYS+WZyu7DENkGwbWfX
	2z+NcweaHwnLBbpiagJmwCSqEUyG9iMYZzOF6BHkFDXH5U5JTu2jKXd2m47z3cn8IeO8mDgZx0O
	vm5FzFn7LzoZCcMYed+LIYymwY8r2V2kwe+Joi9zfPdbR8dbSDLkX2VqN3sT7sLGHF8C1L7OaPY
	2/mtb7jDm0RT8ffjI
X-Received: by 2002:a05:6808:10ca:b0:4ab:25f0:1a8d with SMTP id 5614622812f47-4b240453a64mr13286027b6e.16.1786924836477;
        Sun, 16 Aug 2026 17:00:36 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2714dc18asm2556802b6e.17.2026.08.16.17.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 17:00:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 16 Aug 2026 18:00:28 -0600
Subject: [PATCH net-next v2 1/4] of: property: skip links without a
 consumer node
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-submit-phy-package-fwdevlink-v1-v2-1-23e55dd59fad@gmail.com>
References: <20260816-submit-phy-package-fwdevlink-v1-v2-0-23e55dd59fad@gmail.com>
In-Reply-To: <20260816-submit-phy-package-fwdevlink-v1-v2-0-23e55dd59fad@gmail.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Christian Marangi <ansuelsmth@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, netdev@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Supplier bindings can map a property node to the device node which
consumes the referenced resource. The remote-endpoint binding uses
of_graph_get_port_parent(), which can return NULL for a malformed graph
node without its expected parents.

of_link_property() currently passes that NULL node through to
fwnode_link_add(), which dereferences the consumer while adding the
link.

Only create the link when the binding resolved a consumer node. A
malformed graph property then creates no dependency instead of crashing
while fw_devlink parses the tree.

Fixes: f7514a663016 ("of: property: fw_devlink: Add support for remote-endpoint")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/of/property.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 72cf12907de0..38c0c7dc428a 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1620,7 +1620,9 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 
 			matched = true;
 			i++;
-			of_link_to_phandle(con_dev_np, phandle, s->fwlink_flags);
+			if (con_dev_np)
+				of_link_to_phandle(con_dev_np, phandle,
+						   s->fwlink_flags);
 			of_node_put(phandle);
 		}
 		s++;

-- 
2.53.0

