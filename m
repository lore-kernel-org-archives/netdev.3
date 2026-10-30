Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394991;
	b=0k8X6KZTXFOy+LKchBX1OMEhXL/ZJ4e3rvwcivHuK9vjE6j/E9CVAlCHDmeYEmj72gkN
	 tf6IjkoVc3M9GPIO1aYirYANWIaaQ/qUNGE0Q34RaR1sWIDCzeG51TE1E+MzhN9sCG4/Y
	 j08Kxj+8L/ravd4ImUExm5E67ds8S+bu/2BNQd56l9KupLz8LWOuSqJ0TJDAf+5loPkwz
	 OLabswyxhK4f8ZkYa2w8++jVWoeofQ8kmkyahpEGOJU/3nSay7wBEPRTBvvb8V8vai8D8
	 SD+ATnMiMvgXQSjzZT8KmT2S1+KEqdQmeH5zIr8BWRgQW9kKvyGo2ZChT7n7Cgk24xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394991;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=VE9FP15nXziNfc38hUW7/8pvy2yncMFC7Oe6vk9W/Ko=;
	b=rM9WI6CuHdUUewfPl3r66R+xaoaQmUn2GWPGwEYGMJGo70bN8RI0hDPR/opD4IWGIRXa
	 C3ECIRKISB6yBZQlCl9es24DWdxjiurLUxOQjdlBhquH1bZqMQAZwpV6Y5GIn3JNWg2Fu
	 DxGCY/VR08NFCOrTBRdPRna2EVNRQLFUmWRpy4nCNWU7Gxr0aleLC0VRmf0z6mblbfIL4
	 KqIlXfpmbty5/Gpw0rqSQ4/j5g6VLuuXyiB350ApgT6nIMrlTNKET4lJgdXfm+ZjSBS+R
	 fXhaN+mRNhz9e0893P4906yfq8m0z3DWajAPkDCntYQps8zDplS3AcEs+CX1ZE50InA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Ei7geW8J;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6011606A334
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6011606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Ei7geW8J
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so562040a12.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394990; x=1793999790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VE9FP15nXziNfc38hUW7/8pvy2yncMFC7Oe6vk9W/Ko=;
        b=yZ/UTobeeHQsX0wqwQmF408fxf7sy6yRqEC3MbBeLwDOe21oFvACFsQPiKhO6nniix
         NvFozYxIYgUT+7si2OQZ/u57ErejPe3uYid/yxxW/SV4WYaK6aEQ1Rf10JvvMpflmlES
         R6IMYXdEci5QxSjsyx9JXCQ+9xkDOeRJOdBNsfzCqWchLKvi+SggvX+39nclsOTra20A
         WFvWNsNU+0zPQKBCVDgi57aGFLnfORBZ2U3UWgrLkKEXB5MF6DfZjQ8qBijp7gUaYJbh
         OuARbfoUsjmmD+kMbwbgAUIH1ngMDkkX0UN544Ndh6fUfRkD6FHHS17a6ZPiSmMCfn7q
         1MCw==
X-Gm-Message-State: AFq9FYL3xXUoSL7MKwz6K6P+ts48pgHLWeVHQqrHbqj77AkLDzVACHkA
	+nGlI3sS0D9Bso3SaahvC/OGhVLcD8xfvbMhagHlPmlipvIBZsZzApFyPnPnLmbFMiIcmrJar3U
	AUGf46Odme5Cw+Ba4rSKIj01XKYGLo9+AJLB/pIqwCmUTFt7yT55izDPjryw5fvJzIhb7TpIvBY
	q9BrLidqSIYxKzwv+XSl0WgRRCnYZLIcynP1TgBgjURnSsFiZm1KNYoacB8JdRKETbXaBJ8+6JD
	6NuvvTar64A0Jtt
X-Gm-Gg: AYBFou2BjESJ+Lp5LJc4d9vmPnzb+DmiHTmYzsZh4wU9606P/F41LVrrnxlJvE+ATio
	XhjZpgDb0vyuMr+Sef3VXeVwR7GlcSBgMit/4X+OiEXIPC3hGd9z6t+XaZPvAlgwxUQp5Sg1Pzr
	d5MRRjGAJKFqGW5VlVGcxZfPL+xkf4lSx2fqpilEImp9UhV9JfLEvrgBDUlksqFykN8Dul+u4IB
	/kPZVGXMhpHcqbdOSe1OMfhydAQ6OBV/iyUeZOXwHNfAKyvV6expMSbgEDY8RCcs61WAD6Otu4e
	IU5XmtOxK62+Uf/ZPW3UI71w1FJAp1N+4COXxAwZYbx1KSc2XsaO1mYxBAOFcJNyvf/4ahQVVGX
	InHaj/aGuogn8lkk7XqTNIsUBv8HkP2/XORw64ThPU0CxsYS9RAPSs3U46TvCmxMdiSPWjGJtpl
	m+Qu7aqMSHTtqQ8VSXLOC1u7iayYOMkiVKAw6vErfB
X-Received: by 2002:a17:90b:17d2:b0:3a8:699f:959d with SMTP id 98e67ed59e1d1-3ae89812800mr2956499a91.31.1793394989981;
        Fri, 30 Oct 2026 14:16:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e6efe86sm4761080a91.1.2026.10.30.14.16.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:16:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a1e2485fdso2731587eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394987; x=1793999787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VE9FP15nXziNfc38hUW7/8pvy2yncMFC7Oe6vk9W/Ko=;
        b=Ei7geW8JeJ513OT+E4JfDCGNNenNeb4puZ/BUj0TtQ8oByhpuBZJ9F3UvBYiGaUkNQ
         BGQUWywVN6z3WOKm4jlbOFc4LK95HKAtAJ4dNqzDcw7u0gEdeufWrsLAeo/wmWrXOqyL
         N2ql3I3NViDRoNPxEC4qkh4HSPtzVMDbMceJE=
X-Received: by 2002:a05:7300:cd90:b0:34b:4b99:24ab with SMTP id 5a478bee46e88-36a42454b8emr7297564eec.22.1793394986965;
        Fri, 30 Oct 2026 14:16:26 -0700 (PDT)
X-Received: by 2002:a05:7300:cd90:b0:34b:4b99:24ab with SMTP id 5a478bee46e88-36a42454b8emr7297498eec.22.1793394986011;
        Fri, 30 Oct 2026 14:16:26 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm13513535eec.16.2026.10.30.14.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:16:25 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 3/8] net: dsa: b53: clear stale state when creating an ARL entry
Date: Fri, 30 Oct 2026 14:16:12 -0700
Message-ID: <20261030211617.288562-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030211617.288562-1-florian.fainelli@broadcom.com>
References: <20261030211617.288562-1-florian.fainelli@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When an ARL lookup does not find the requested MAC and VID, b53_arl_read()
returns the first free bin index but leaves the entry populated with the
last bin examined. The multicast add path then ORs the requested port into
that unrelated entry's forwarding bitmap, potentially forwarding packets
to ports which are not members of the multicast group.

Clear the entry before creating a new one. Also return without writing
anything when deleting an entry which is not present, instead of making
a new entry from stale bin contents.

Deleting an entry which is not present now returns -ENOENT, including
when the lookup ran out of space (-ENOSPC), where it previously returned
0 in that case.

Fixes: 5d65b64a3d97 ("net: dsa: b53: Add support for MDB")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 559d4b360c82..c38e8c5838bd 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1990,11 +1990,15 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 	case -ENOSPC:
 		dev_dbg(dev->dev, "{%pM,%.4d} no space left in ARL\n",
 			addr, vid);
-		return is_valid ? ret : 0;
+		return is_valid ? ret : -ENOENT;
 	case -ENOENT:
+		if (!is_valid)
+			return ret;
+
 		/* We could not find a matching MAC, so reset to a new entry */
 		dev_dbg(dev->dev, "{%pM,%.4d} not found, using idx: %d\n",
 			addr, vid, idx);
+		memset(&ent, 0, sizeof(ent));
 		break;
 	default:
 		dev_dbg(dev->dev, "{%pM,%.4d} found, using idx: %d\n",
-- 
2.53.0

