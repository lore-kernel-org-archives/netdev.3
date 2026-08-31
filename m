Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91A23D093A;
	Mon, 31 Aug 2026 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168981; cv=none; b=ucIExAdP0rXm9jOmrzYXWvcoBuMKRXCsUOnkEKQGD/0DZjqC0jtLv7E+EdRoQlrLHmC1eA0be2A9/c2KLfzMXOv7izlEcvQynZ+3Apxu6bSWjOpe2aLf2POsy/QFHjFmd/gC4Lo1lw4wUmlHE6oeIydT/IOAof1VD8crtVfplII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168981; c=relaxed/simple;
	bh=KO58p0Ae6Jri7xZx0xr2iF8axurkxY4+ZoZQSU/NPzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnajf3Pe2W8m782kTRDEsym1NUqvfdCG/ffhKF0TqHE0m4nFAznLgbnS5xWIJ9k9jcKtyJolSDGKFYmEI7NxRD+vl7r40M5m+kgWG+drLCWcg0VMuN2Tf7ySJ2n+r8f5RMs2ZgZWymo25VBixqF9lt9jjiB7bc3JvS6vlh7/KPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=dsghy3/R; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="dsghy3/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1788168970;
	bh=KO58p0Ae6Jri7xZx0xr2iF8axurkxY4+ZoZQSU/NPzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dsghy3/RJiF7vSHxBwPW6bLKHnE5OzaCD1TQJ35xZmngyZdy8P93QxrPAP7+jBBvd
	 tdTWHUUSZ0A2mYnn39hZt/UTt0n0b1mBsFgHguWfUoEENlRNAuY+h4r/o7UytQItkU
	 Nzo6m7tMmoAhgWLnRnoABHr0ZhqDUr2306iA07csPP/J9gJMUWGIXKm8yRVIQ1nHEW
	 v1H4YbbB32ePo5GImS/cuB5ZAnu1NdmA8YkRscY0Sk6XfozKmCef6LwVL8uCyfIek1
	 iAnFNEFfXod6lOE6r+uiNffyVeqjTlwWEcK682hz2ZEwOSkPkYBfKhn+tqrFao8U6d
	 R3swD5i1zTzqQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 0BFA9600FC;
	Mon, 31 Aug 2026 09:35:56 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 32804201D69; Mon, 31 Aug 2026 09:35:24 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Felix Maurer <fmaurer@redhat.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Gabriel Goller <g.goller@proxmox.com>,
	Patrick Rohr <prohr@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] netlink: specs: rt-link: update ipv6 devconf doc
Date: Mon, 31 Aug 2026 09:34:53 +0000
Message-ID: <20260831093458.472180-2-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831093458.472180-1-ast@fiberby.net>
References: <20260831093458.472180-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

devconf is even odder than described in commit 720447bd0b24
("netlink: specs: rt-link: remove implicit structs from devconf"),
where both IPv4 and IPv6 are described in an identical way:
"u32 indexed by ipv?-devconf - 1 on output, on input it's a nest".

There are two issues with that line for IPv6:

1) The subtraction is an IPv4 specific quirk, to avoid having an unused
   u32 at index 0, thus saving 4 bytes per net device being dumped:

   - In include/uapi/linux/ip.h the IPV4_DEVCONF_* enum begins with
     IPV4_DEVCONF_FORWARDING = 1, so the enum starts at 1, which is
     the reason for the subtraction in the IPv4 variant.

   - In include/uapi/linux/ipv6.h the DEVCONF_* enum begins with
     DEVCONF_FORWARDING = 0, so subtraction would underflow.

   - ipv6_store_devconf() in net/ipv6/addrconf.c also doesn't do the
     subtraction in the output path.

2) Setting IPv6 devconf through Netlink is not yet supported, as
   IFLA_INET6_CONF is not handled in inet6_set_link_af().

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/rt-link.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index b80c2ac3ac31..00c915031efd 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -2218,7 +2218,7 @@ attribute-sets:
         name: conf
         type: binary
         sub-type: u32
-        doc: u32 indexed by ipv6-devconf - 1 on output, on input it's a nest
+        doc: u32 indexed by ipv6-devconf on output, input is not yet implemented
       -
         name: stats
         type: binary
-- 
2.55.0

