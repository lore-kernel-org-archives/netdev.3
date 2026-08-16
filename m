Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175E3B388F
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786921196; cv=none; b=s/WlPTr4BeaVnF+lwxNRqmMc2OFEzTTVmzUm6UyVMUih70UeJQTpookQYdX1oAFfwQbz9G6U8zsD1lgr+5Q9XEcW+SEn/CFzkepKl9gJJMl88KmB5mPsM7eHt9YdWaLhAOUGIWd5MN/vMEaTOiyKb2bU/SHcad1PdyVIVhnuiJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786921196; c=relaxed/simple;
	bh=m1hIj45rBCsnQEDRiYtKB+o/8QDizGsoyYI9mzepPSg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Qo/RlKe60x+ITgkeORlJxrMzVyu3goTJWVl18qZwaCFQgFCVTcpS1yC+9pc1aeacQeITKGijBq94Q3Zdz0TG+YppxQ8cNHvw5Cg93pFX++G1hkXNbD3o2Ks0QX9eyud9U4gFQfsgMVweWM3kxDApavDN/goYcWNWuQtfx9WEXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkAthDdh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkAthDdh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31481F000E9
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786921193;
	bh=m1hIj45rBCsnQEDRiYtKB+o/8QDizGsoyYI9mzepPSg=;
	h=Date:From:To:Subject;
	b=bkAthDdhbkWO/325xeCzZkOfF+I/w1RAWS+mrtuG/wy0RRYGvUpdf1lHZqAV1n0km
	 qFuJypg0p3GKSUpaL0k88ZzF502Z4IfydPOE/pcXLvG4HXsW8Q0wJ3mGtxFDR37k10
	 VnkbFPY0DpFtA91stNHD3bODyEvh8oQigBtgD+tTI1LGaQNcw2lVzSHjMrm9qQZ3Ro
	 Rgy+lRkXmifKZLgNm7f49OyLF2XdDT82O6341noO0jWvHRzuDVVYh+apUOlNx+EvUq
	 7MvltOW2vX10iXxRWXD883zLZl34mz10JdS5Zudmx9Paw9QzF1s93gbsnsJu1UBfat
	 WZ1gbQ0zcOG+Q==
Date: Sun, 16 Aug 2026 15:59:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [ANN] net-next is CLOSED
Message-ID: <20260816155953.072d73da@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Linus tagged final v7.2 so net-next is closed. We will look thru
what's one the list, new net-next postings have to wait until Aug 31st.
