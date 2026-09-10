Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEAD4718CE;
	Thu, 10 Sep 2026 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078794; cv=none; b=tYxDHSSOY4/53PdlzCvjfbI65g+/nk8QxyCMRgc1fjoOkzICUem0heSFQvsu3m/koznQmFSu5lO2XPl9HL+GkUUtjYm30eajkyCb72sQo8RO0zKkIOY47lJwNxU5z0ote6/ncnmE4t4AxYAJ4uYxVtKYgypDFu5C00mx8/oEEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078794; c=relaxed/simple;
	bh=4e+druWLoSy2UHuYMyQg4tDAmJG8hx9w/GmFCwb15S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keF78wjHbpKknwKL1WSG6M1GNz27lgPUUFwz5L566mVENgl0RnZ0K1biGAiOAripqxUcV02RE7pCRfERv30f5KEz5Js15wrVGIjvAKa5TtvrisHLYuDUEzGnfrqJGqDwXoFsrb5xk5roA3fb8vwRf9vQOjyF7qB4Szs+PBCvcZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ge+Ffk52; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ge+Ffk52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789078778;
	bh=4e+druWLoSy2UHuYMyQg4tDAmJG8hx9w/GmFCwb15S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ge+Ffk525r2KWvpiyogarLwOvHbijIMNyCeQZRs8XgmFcblL08/Q5yl5t2FLSMLWb
	 9XfakllRdOtzMUKLc8O89EN1mOUjM2LZvDaBBmsvTEUPJqniKLU3mxetfkwCGxFgRG
	 ldpjrJmtx3v7fP/becGBxtAAIFeDUYGBf/nglyy6FdnHUq6VCWrlbWpOvrPDOY9L1l
	 RgLKMsoNPLQYir0OOb/kzbnxQfeDa5kdCqcSu0mwUlQTEi5lJzOccqQ73sUO9XTSWz
	 WS3zplUxRe8OfsCz6nQJw2/1kJUn8oGopFVXwCTUoh7T660xJMx6xYWDC46Xye7/VJ
	 X2qhBgCoU2MHw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 30859600FF;
	Thu, 10 Sep 2026 22:19:19 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 429742022C6; Thu, 10 Sep 2026 22:17:37 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"Matthieu Baerts (Netdev Foundation)" <matttbe@kernel.org>,
	"Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Heng Guo <heng.guo@windriver.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 5/8] netlink: specs: rt-link: re-align IPv4 devconf
Date: Thu, 10 Sep 2026 22:17:25 +0000
Message-ID: <20260910221733.1021864-6-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910221733.1021864-1-ast@fiberby.net>
References: <20260910221733.1021864-1-ast@fiberby.net>
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
index a74108072ce7..aee516e87b89 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -312,6 +312,7 @@ definitions:
     entries:
       -
         name: forwarding
+        value: 1
       -
         name: mc-forwarding
       -
-- 
2.55.0

