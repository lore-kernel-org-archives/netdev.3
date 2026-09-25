Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316ED2D77F7;
	Fri, 25 Sep 2026 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372958; cv=none; b=GO3Oha24h/gGfS3GdEnFx/RzF3aECO+i70VFj3o5Le+4hHZFybYXXMug6qOxkss5hYLrTD5+fdpoD6b6TO/QEgiF+43vYAjtRtLrTFmVQ5f33WIMR7rx0i/MGi+sBylIuapmd3k7/+igUqEoF1o3+0FenGbu8yv2qpuQiSu+gAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372958; c=relaxed/simple;
	bh=AN4zZMvqmdofDWDS/eiCGdhNdx97z0wHK5ucQU5d808=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PP5Hi4vF0O8rRy4TvBE6SQ8shDL5RO4tbQ0mY0eEwAcfvsEsaDJIvowEZ1K1HtSVigkRnNOjeOyU5OIUdv6BeV4+Q2+eVtSxuMDiAVrcdWmi4shIkRYIvTWU09+1QA0JsW169GnScVHLEd+dkS9JEi80YvCzIQYQhU2OALU0pwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=HSQirv7D; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="HSQirv7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1790372389;
	bh=AN4zZMvqmdofDWDS/eiCGdhNdx97z0wHK5ucQU5d808=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSQirv7DNr45bEq9R1lu4eaVUiictWuRFEYL3dQaopoQY+DpWieMntCbU4Gk37M0M
	 hbeZXCH/tMBoogxVlM6XDSX1pBT1aLgGjcgW79vsWgwvn0XWVavv7WqG7gDvmfDPU+
	 xzuAKoWv07zmpzNsOd9AbYBQ63NrWHUNkYiZKOkXo6zPzNltaamjrgSbdmYkJ5MtU4
	 aZuH7bYgxUveTdD2wFXxvp3eRXqt764jQZa2XPZeTybUs0GW5VWnhZhKHuw+/9Cdfb
	 i/i/4Yih6LOKZ82bYe+wzt+0CdSAl7HhhloUevFAB7VhKQROuzvQ2/U09IXgpUB+K/
	 iJo2tBfaKSQ3w==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E9AD1600BF;
	Fri, 25 Sep 2026 21:39:48 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id F38C7200F1C; Fri, 25 Sep 2026 21:39:20 +0000 (UTC)
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
Subject: [PATCH net-next v2 1/9] netlink: specs: rt-link: re-align IPv4 devconf
Date: Fri, 25 Sep 2026 21:39:04 +0000
Message-ID: <20260925213918.204767-2-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925213918.204767-1-ast@fiberby.net>
References: <20260925213918.204767-1-ast@fiberby.net>
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

This misalignment has been present since the spec was added in
commit b2f63d904e72 ("doc/netlink: Add spec for rt link messages").

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.

 Documentation/netlink/specs/rt-link.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 7a72cd1b7e1e..8d63933f9910 100644
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

