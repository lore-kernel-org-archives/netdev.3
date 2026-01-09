Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F504315F
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993502; cv=none; b=Slx2CfH/BAOiclVMi2BLUH3dvgJ4F87f7ly+bSxamfMx7OwkOxiXlLaVtX2U4azV4aB6SnjIcciNL1D4uXtBk13lnkDYwIFxWOD4M15p+XnYlDarvskrNvilx/JS/v6FRYSK6UuGciMJTsV9kGjIN1OEAXRWrEBZ89xBvJGgVwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993502; c=relaxed/simple;
	bh=rvuNAvvXGeoaEEyfs0gNxETvHfrvsyUDnUAcC1/0aeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VUgsFdA2SQCo2Wp9zDsRdnBIC9PpKzRbHGFCxG8ebdI2/D+u0PHEL8+joqmoDXpjgL/bDxHYPWNKGDte2LJdcDX8yG14m1NC/N3nY0JiQzbT1/Hh1vOVpry+4xigmK243KpDAvp6Xa/gxxzkx+g6re9guH0wNBI4fCv87LteTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5utRB1n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5utRB1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5CFC4CEF1;
	Fri,  9 Jan 2026 21:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767993501;
	bh=rvuNAvvXGeoaEEyfs0gNxETvHfrvsyUDnUAcC1/0aeE=;
	h=From:To:Cc:Subject:Date:From;
	b=m5utRB1nRnsts23fuhBufrj+Sw499zZQs29J60hP9Elv/KyZQn8f3OagCOCjhQOOp
	 sN1ezqevVk+173rkAbgUNXiXlbT0RwzxgUtY3ZDLTnCwvpn1FJhjDRW/3R7YQo9f6X
	 4vTbs08rdBd/rd95RoyVHXtOKLTynwsyydHXiG8WPomhkgCRRmAsdbVPRS+jm65Ap3
	 Seh3+xh/MW1RXhXNjlXzTJKgunqOfPzSeGt3lbACx5YJKmydwb1IMz8xhO2g9UZRsa
	 GXua9Kj6SdkznxHDescnnPsa7+34w3DbTOh7tf760rsklJlhURiD+Btt/xj+/X55k4
	 L5QSCrlRUBAyQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/7] tools: ynl: cli: improve the help and doc
Date: Fri,  9 Jan 2026 13:17:49 -0800
Message-ID: <20260109211756.3342477-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I had some time on the plane to LPC, so here are improvements
to the --help and --list-attrs handling of YNL CLI which seem
in order given growing use of YNL as a real CLI tool.

Jakub Kicinski (7):
  tools: ynl: cli: introduce formatting for attr names in --list-attrs
  tools: ynl: cli: wrap the doc text if it's long
  tools: ynl: cli: improve --help
  tools: ynl: cli: add --doc as alias to --list-attrs
  tools: ynl: cli: factor out --list-attrs / --doc handling
  tools: ynl: cli: extract the event/notify handling in --list-attrs
  tools: ynl: cli: print reply in combined format if possible

 tools/net/ynl/pyynl/cli.py | 210 ++++++++++++++++++++++++++-----------
 1 file changed, 147 insertions(+), 63 deletions(-)

-- 
2.52.0

