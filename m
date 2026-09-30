Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA664582E8
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803419; cv=none; b=R6RiM6C3r+kdeOElb8QPP48k326+5KoaARseFIR773mY/tg9Aq1QFpxUkZH/hpKY/prp1WlQw8wHN4aSWhJdbzmhIZo5vpYMZabifFRZpMRwGheP/T7CobdJ/BWvpbET4U7cYZeSXqeExwm5KY9VcYTMVXb9Zxw9PzTZ3K6v+H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803419; c=relaxed/simple;
	bh=xtBz/Ol8neW9iAfoL13hL7AWm7dg7xItra2S/I0XCDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/6kY4dVd4FW9XklsNeQ0OTjMu3GgxgabUlfQ7TnXlvN2hYC2zNMuzOQDJc7evDFoLPfiv70y1F41GHfUrvYOj5EurfqRJXY2vOV451x9J5m2gfeTEc4HDcdCUmPpPd5kHLU9hlxfyILPNpgrQ3hE6kzJrY5EaujPa5OYXVMTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2Cx68uL; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2Cx68uL"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e1432bc59so186496766b.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790803416; x=1791408216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xtBz/Ol8neW9iAfoL13hL7AWm7dg7xItra2S/I0XCDk=;
        b=L2Cx68uL7UZjpsUxe4pmLTVlWgCEEVabOdhD6GCd4YxrXi6PNyB65U8Hk5nausP7uL
         NkfKh8SIR8F8RgCjokO5ajZ/bb8qpeWA1+tFp7Z3+6BK4V/MG9zJS+llOXmnqzzTpBM/
         Tab059avhXdAlIAfujKQCW+m9bXHXFYsZSSvGVJ8HF1VE6n8Th9IP2VN4XCJXsdvMblL
         ygSwwnDWh21WFNlAbXy7oQFGC6SML0JDzFvDXDVdUsc5KuRBFS2hP2OUEwna1XXwpnzp
         y+d8JYjs+o28/lvsVn7aLweW4ohWMpHy1b0HHsg4Lbk1bgEsHzO6Asdri1gUa6/9jQuG
         dYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803416; x=1791408216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xtBz/Ol8neW9iAfoL13hL7AWm7dg7xItra2S/I0XCDk=;
        b=faKVMnUncdG6RgbQtF2gij30LRqrSHRL66r5Qm2LPYIOKfSpvkWXglonvIl/J44zgh
         xaiHWJjgHJy8zmAs18zFYj88qK5VHfAUrYjci17jZqgSjt8qML5QpOL1U2FHli7FiUI5
         nOjyIM9x8CqR2QlSP+mUaCP6qQuwP1Hxc+tInxSjBF/L/hrGDalY8hjvPetvUTqy08/c
         hMda+nzZLSeKWF+vRAhTQSsjh87Fmj+Jbib03YEGNSMIhRkHbz2Rza4duT6v7USPB7zA
         TVDt3GE65TLQhdUx12U/NJHnd7OhMRVVg5NIoaEUoL7alPu2s7uJe2cUB2EtuSOIrOBn
         xGiA==
X-Gm-Message-State: AFuF++nOifcCdJTgrp7rh2axwS+rc45qHui35bkN1g6IbTxeo1vpE2g2
	K6x25nJbH5zZzt/fMRhyb1JFyJwHfzQJ3RGoI3bZsuNjy2GgRZvOLNWF
X-Gm-Gg: AYBFou19zUMyyDibxS4YEt7GgWtooX0wjqfOBHYYKnmBIIhlfgNscb6X9/emoEO6a3+
	IDI8pBUN9Yuu6//Hi2UFelZVsAsxdrg71Fxpm7akIrdkQ5ybG9d6tih2cPshlW/Hdg5TNRGjLsi
	Z7HdxmhcV6W1vMxn8HaXCjRZsQGmKX6Xcg4dExZ1+T73ZChI1MVIrI67qVUXlrVQ8PfXegxFD7+
	NUklfx+Mn6AG4ZFMSUb2NGSg4hvTva1XWgVE5K81wz0jh0pS3lPUJ0hDxhrIcE6V1gwIGGF2t2a
	PVuZYhD6KHdQWhn/O6Du+MXZB9kOBBmqRzMI4nm9zEVvQQm7SYoy482cXxO86cNoNb/BvhqVAsx
	vP0UGSw3ZjcXPhNnUiUKru1gByiZ7hl48pWpUjVUjw1dH9ybQ1pPWwkOpvkfktSUeKKJtAWkUFE
	bGBi5eyAlR/19Y6wxzxMNlwE8NgMtqzVOkFu4WhkjEytlmEPilJggdX4+GdMVggn9yYqOZC3edz
	WCL7jHdJDYx9WbRPUSwuisy/ZsdxAyCOklqiAZ9cAkviX4XUbXMx0XPhqI/Usr0xCKxd8IrePWd
	wqPVh7PaBEIYDmE4RNpGoNdBV3ka95k=
X-Received: by 2002:a17:907:6ea9:b0:c29:3aef:f2e2 with SMTP id a640c23a62f3a-c2e23dbee0emr209042866b.40.1790803415701;
        Wed, 30 Sep 2026 14:23:35 -0700 (PDT)
Received: from localhost.localdomain (83-233-221-82.cust.bredband2.com. [83.233.221.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31d3939dsm58665066b.43.2026.09.30.14.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:23:35 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Crispin <john@phrozen.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net: dsa: qca8k: propagate MDIO errors
Date: Wed, 30 Sep 2026 23:23:23 +0200
Message-ID: <20260930212323.1031-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <12875133-1659-4507-a007-c3cfa425ec76@lunn.ch>
References: <20260928220629.238-1-yongzhao.derek@gmail.com> <20260928220629.238-2-yongzhao.derek@gmail.com> <12875133-1659-4507-a007-c3cfa425ec76@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,=0D
=0D
> Does this actually bother anybody? Have there been reports of actual=0D
> MDIO errors?=0D
=0D
I am not aware of any reports of real MDIO failures. The evidence comes=0D
from code inspection and fault injection in a model test. In the next=0D
revision I have dropped the Fixes tags, and I will post the three=0D
patches for net-next.=0D
=0D
I have also fixed the reverse Christmas tree ordering you pointed out in=0D
your other message, and checked the rest of the series for the same=0D
issue.=0D
=0D
Thanks,=0D
Yongzhao Chen=0D
