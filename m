Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699994991B0;
	Fri, 11 Sep 2026 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162969; cv=none; b=nA0+4psxXhVDdf1CT+1J/f8d5GV4+iiUxMo+oZWlID/ubOdfs/USfQGMXhy5nkbeKladX393HnNgLm75mW1JlXlcpYs96Kp+3JMTvAE4Subk9zOTnzI9jF33Qe2gfncQluOukDGP4s8ym36K1Nxpm4erX8H3zU2+8z5WaxHtkXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162969; c=relaxed/simple;
	bh=r9hiroYnEShfmYP9hzodeMt2HrdVtmfLVMphYyKmALs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpRCgbjs/NL43tuGC3zraOPtisJPk3NTUYy0FwODndG2tm8Zw3072Z8J+51WtUsoU9xFWRYJEe2M6OQlx1F8Wz/d5jrhWdHOMNlhurKNSU6JQ0rb1FLWXxchJsvQwHYdxRfd/H61n9cGjElgPmDym2oeZ8mA1ifuuBDU/2+6Tjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=C82diH8Y; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="C82diH8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789162963;
	bh=r9hiroYnEShfmYP9hzodeMt2HrdVtmfLVMphYyKmALs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C82diH8YE4WgU4BWQP/VB86sC9UUKEVHSRQ4F1Euvj7wgYsLCkj+cehU2AgrOgMZZ
	 KgVnMP5O0YaD4AnL/R0YFM454+SpVb0+z6YXyRyswZYwH0mCd9kr/nSyzrWlSH/OvC
	 v1juRqiC/GFvpcdOqmymkWIMpJGN8+JDan7DYUPCPJBFeEkAWxuqV7kgFEuUPTJ96/
	 0/AVMlic6F/IM6m1dmlMrVn3l29zLQjtqUs+y9AtYLffpOrVHRS7/HGR4NE4pzp7rT
	 Pv1E715+1cMDvM8NxSLtuv/V6nz7fM7ndyG6876RjppWt7+npk9K7xitz4KMuZL8MM
	 pNO1EmYJf7tHw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 91DB860114;
	Fri, 11 Sep 2026 21:42:43 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 6ACAE201A76; Fri, 11 Sep 2026 21:41:53 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/10] netlink: specs: rt-link: re-align IPv4 devconf
Date: Fri, 11 Sep 2026 21:41:27 +0000
Message-ID: <20260911214148.1184806-2-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911214148.1184806-1-ast@fiberby.net>
References: <20260911214148.1184806-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The YNL "ipv4-devconf" enum is misaligned with the IPV4_DEVCONF_* enum.

IPV4_DEVCONF_* starts at 1, ipv4-devconf starts at 0.

$ git grep -B3 -A1 IPV4_DEVCONF_FORWARDING include/
inc../uapi/linux/ip.h-/* index values for the variables in ipv4_devconf */
inc../uapi/linux/ip.h-enum
inc../uapi/linux/ip.h-{
inc../uapi/linux/ip.h:        IPV4_DEVCONF_FORWARDING=1,
inc../uapi/linux/ip.h-        IPV4_DEVCONF_MC_FORWARDING,

Re-align the YNL spec by explicitly setting the first value to 1.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/rt-link.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 5217d0bb4a3a..6d5f50c8362c 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -309,6 +309,7 @@ definitions:
     entries:
       -
         name: forwarding
+        value: 1
       -
         name: mc-forwarding
       -
-- 
2.55.0

