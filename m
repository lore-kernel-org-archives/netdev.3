Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0062335C69E;
	Fri,  9 Oct 2026 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558968; cv=none; b=WHFkmGB3ENI/eNIg1kbtWztBU1MpaSmERSpM6PLR/mbLZxtlog9rHA2MM6g+xP2moBQsWxL68DyCLsGOQDTtaQJ3Q+NXeNzpFUqX2vUfkaXZigYqrLDVq4O0hNKsqR7F2NBuVaq/fucH7c0H6dm7XdMsQD/Yo28zQd2SYQRlX5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558968; c=relaxed/simple;
	bh=o4+ZkyO2VmGyXRxiDbs8VVTEX6tQ0BmyOL11epC4bqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hHqZpNlQCpWD34JqlaG8yOm5qhEZcV02i02/uIpRskgLCqLXx8Ni1cGHS/4eSYqOVJCYEbfAcINNSkc2/ir4KrYh44zvWm0ZraDaGp78B0gbhJS+8Lf6f8ZUKLEyKIjitwV6Bis2NUQVFn77eiH8J9/m9lQGxaxZrt6Y+6L5fDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cTy03ma2; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cTy03ma2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=ayFS0Are3+5wgCM5+cbAMqeFBhyvNmxcL24U1rZoH4Y=; b=cTy03ma2JEgNGnnLyrEoDt8Kgh
	iTahBQ1ERMdxtoR8W8svYYZvfe/CY8PVQ737KAeaSOdYQlcLwU58xgBVyLXgVmaJvJF+5Qd8+cs2+
	hsiV4okIbs5JB5d3o98Bfm8gPFFyeFDknKTeyufAgSBzoIHjw+M8Q43YM7Rr+RLNAM7sTHCrbT89G
	bEcWxSBjtNVyFX+1L5/iJYs8T/H4fHprGgVDK935gMrLhRdmprK9NRLNrUkL104vjc1Va47C+joL0
	TpOppKOTApB1egOU0Z/9Gqsg3MrGkLz9Lr20i6uuoZKRi7cVWEtQJt25EJcwgANGo1U0PPKrbV4sc
	48dBFlPw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xFCKE-000cVw-00;
	Fri, 09 Oct 2026 15:15:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 09 Oct 2026 06:39:25 -0700
Subject: [PATCH net] MAINTAINERS: add Gustavo Luiz Duarte as netconsole
 reviewer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-netcon_main-v1-1-6d298ab5a0cd@debian.org>
X-B4-Tracking: v=1; b=H4sIAI3uyGoC/x3MWwqDMBAF0K0M99vAxEep2UoR0Ti28+FYEhFB3
 LvgWcA5kSWpZAQ6kWTXrKshkC8I8TfYV5xOCISSy5dnbp3JFlfrl0HNNTXzVL3b0fuIgvBPMuv
 xbB+YbOiu6wY6MIW9YgAAAA==
X-Change-ID: 20261009-netcon_main-5400d389b11c
To: Gustavo Luiz Duarte <gustavold@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=826; i=leitao@debian.org;
 h=from:subject:message-id; bh=o4+ZkyO2VmGyXRxiDbs8VVTEX6tQ0BmyOL11epC4bqg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqyQUpQqP4LNKKB6ak/CQlSFgGOV3jlk2mVAPiP
 VvlkF+j7VCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaskFKQAKCRA1o5Of/Hh3
 bYeaD/4iKgK034u3f5Qbix86zNCsgQuDzl+sJvV0HCuyP7sKr+jCSGt9WipalfOnvZh4iCasT8g
 6u85l0hVd5HC3kcETfoldUeb/Yzgw58gdT+d/fz3wauGljDoEk9un49Z5teOaR1BHBXju9sT/kw
 xpGLmJR/EzT1D2FLIw8H2JCbMxWzMVS8RwsGc637gP4Vzf+kFIeUqUT6y96iutxM66M14MWr4MB
 4hSNC6Q+3ZswsL7K9AAYexrigKneWbI0JmCWXGNmrmsW2dCE49IZ53zYf6Z8KgmBSlmtoyvsotB
 PpwUn9pLLV3gSZ3W3Brkf78v/womexMWWi8hpbp+AxkPA2o0ZWT/Qypcnpy7o7XNMFS7qftdf8Q
 OtksDXPOCQD3S4bUCFOAAqvRPXwM3TfipTaDNs+kRo/pLb++GDfC+nvVA6tf6DIa2nbIxQK+Kfv
 N/XxtpH6MIskSYt6Zs+4GT1rpuwueAprmN2KuVVikOu7cGSvsGqJAAhvv8OLTsthoBLeL2gmb14
 dB7exTm6kRyH4PsBU9PgQeL1/66c5jBA6SDfD67Hyzq4x8j8CbyGMjWN5mIVMDItRCFp8+b0d87
 NTfwfDaoZAmE2wJKBvRNMy92Z608KjupyExiwoH4cT0OlAz0wH26ZGExLmrwvvLVBMKLS/T/Yw6
 3ku6zIRn0K1m7BQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Gustavo has been the most active netconsole reviewer, let's add him
to the MAINTAINERS file.

Add an R: entry so get_maintainer.pl Cc's Gustavo on netconsole patches.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 509b35b5a0e7a2..2795a65fa50751 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18831,6 +18831,7 @@ F:	drivers/net/ethernet/nebula-matrix/
 
 NETCONSOLE
 M:	Breno Leitao <leitao@debian.org>
+R:	Gustavo Luiz Duarte <gustavold@gmail.com>
 S:	Maintained
 F:	Documentation/networking/netconsole.rst
 F:	drivers/net/netconsole.c

---
base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
change-id: 20261009-netcon_main-5400d389b11c

Best regards,
--  
Breno Leitao <leitao@debian.org>

