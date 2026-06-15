Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB880401A26
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538792; cv=none; b=ZAb1/fGyT7G0Ahnq02UapAuCOvBhQQM+L5GjG6dEK+b5HDvj+PxlPMvIZy6xsiENYlf8mLZ3etdfkouifZiCOIbAzYuy80QtFRLkrJnm+8XOGl6Lc2GATMvSsEWwDJuNXSmNoxCojn1AqTopqyPzYqnyrQ77ggZ474/EwgoyEVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538792; c=relaxed/simple;
	bh=DfMD38ysvo1H5gxy2fPNUqAISdJh4UvNmcOiSAw+46s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=lou+lK26DaM9JVeJzLSTYtEPV/pgIY6WMfjifSopSgQ594QVijqr7vCwbkGlzWoIDTPDV81C2zFD8c3x1tu4LfdIv+eKbJnp7cOTJRN06PJXqpdpwuULkf5ysyrVTtlDHBdXi+rsT2MYLPNNq4fs2MrwFFv8A4J/v3W9NCKMuyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAYQR/Kj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAYQR/Kj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F311F000E9
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781538791;
	bh=DfMD38ysvo1H5gxy2fPNUqAISdJh4UvNmcOiSAw+46s=;
	h=Date:From:To:Subject;
	b=XAYQR/KjdwnLmI4jnfJ7P9IHgHAIl5YEG5QDoOZ/C5YygOWNMTe682Fp+5BUQEjLa
	 TlCZUVIof42xqtUrO713qc+auswp/QDlKxMKoWmM2vbJM9WR1KRcYBwWFiBpj8s1ML
	 s1/i/zDoQIfDJUsTEN9B39zsjk81FOGT6+BsZjX/swegqOlweAyoBQrclOU5deY/lA
	 Rulz7Li2fjTrdq7c0ksasYM/jlstutyDXmvOptDt/spurfjxzuS2wWoYp2MvAkkhc0
	 F1mgTY2ohF9XlltgVgM6vWVzl8iawy2ClttMbmaHFXk3oj37TXutaGfDjp4s/dMhuO
	 OqLfGLW/avBwQ==
Date: Mon, 15 Jun 2026 08:53:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: net-next is CLOSED
Message-ID: <20260615085310.014e4e31@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

net-next is closed. There are 350 patches in patchwork.
I suspect I can get thru around 100 today, and that will be it.
So if you have a negative reviewer score or posted after Linus
tagged final - expect getting the usual form letter about deferral.
