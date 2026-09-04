Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9AC352038
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549035; cv=none; b=uwZve5/if2MzSmxjfPpWOGNONZQa0KsWfjF3VcYluXF63tllpOUdsY52+cBGOwXNjVL4+Ad27cB7QVAdzCzkWlno7KLF+3jhIoouEmb9TSfR+QHC4NHcQOJurOGTvgAc0RUs0nso/AMuttxiPq8OdIirZtfr++jt4yKV2GVDzbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549035; c=relaxed/simple;
	bh=gzRoBRRz17sB6lt5i2oxOxrZvCyIF4N01lXisp3sYhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kqr5detxvVWbgfN+67Y3aLEtn03MI10toHOXIFJ1Wzxv8limo83XZ3VuXROMqUIkmj7KHCmd0pJmFGXSkA/tdr8XHX7THpMWHXAK5dwC000FXVtHgwYFE8iagx1FvlQpOFKhAYtsvpytWNRU3EKCYkSi6aUphoWA4LyhASkouuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTK5aLlA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTK5aLlA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5805E1F00ADB;
	Fri,  4 Sep 2026 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788549029;
	bh=PM3+KgdiH9tRvN2ar5WwQFDBK+21ldv5qlCDbM16uG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TTK5aLlAm4L8/t4WN0OhffBtsoXiMZXL+DQ9taU1f0lO/MTlv9P2w74vmPEPq20Tn
	 rRbN5/Ld/EiD/++u8823BbWRxTRE4laprh8NHBWT79KgBjISwk6Bah9YFsDCISZ1P8
	 +4o38GxKrsDmT5UG+lpJUShLMNz90m8vs62dQ9F92H1HAXMGD2mVXo7NnqwStkLUc4
	 9XrceKwjQpoN1lNzTy3vG2fwu8igaggJxb5LrTXonFzTsZXhwXhGwrD1iPkZJmp3Kz
	 52mAhjnTR3t7hi4heDjDZsuciO2NjMRS1wz9eafRJqjavcNFs/sjzTfM4JP5AaDvUs
	 0PPyJaPIQZkaA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/4] MAINTAINERS: dpll: add the netlink spec
Date: Fri,  4 Sep 2026 12:10:23 -0700
Message-ID: <20260904191023.3869690-5-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904191023.3869690-1-kuba@kernel.org>
References: <20260904191023.3869690-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_maintainer.pl on Documentation/netlink/specs/dpll.yaml returns only
the YNL and NETWORKING [GENERAL] entries, so a change to the DPLL uAPI
description does not CC any of the DPLL maintainers. Ten other families
(binder, dev-energymodel, ethtool, handshake, mptcp_pm, ovpn, psp,
team, wireguard, rt-*) already list their spec explicitly.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b23fb6f2f4ef..b000853829b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7919,6 +7919,7 @@ S:	Supported
 F:	Documentation/devicetree/bindings/dpll/dpll-device.yaml
 F:	Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 F:	Documentation/driver-api/dpll.rst
+F:	Documentation/netlink/specs/dpll.yaml
 F:	drivers/dpll/
 F:	include/linux/dpll.h
 F:	include/uapi/linux/dpll.h
-- 
2.55.0

