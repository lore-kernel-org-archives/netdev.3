Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57603A963D
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708166; cv=none; b=PFIgC9jHXc2Gzqd2vsJxMaVDN2JLxI5XxCEvcmvh5+gLKeikzS34OBheDbA7P7QB6SAXM9XEThSeot4q7fFJ03tYOr7y1CokxwGnCOnAzd323pSECvnjG8pVzAkXi1H6HlFHRBrXIZ1wuDIi7NFxd3LvydRcIkam36MoOIJD+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708166; c=relaxed/simple;
	bh=1l8v/fESj83GAnrDRzaGZx+a+AQ5uk+B6lt5KCjkDXY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Sy5ZLpTr/INrz0A8dBM0SnB2nQzf9r2yQqQzymq2uOYkxaWCSJpHPBNtEcyUgMc2Y+R0S9TyCNx13/ejsg/rirGwi6E9bR1rLmp6E8nGa90rx30zcsBroIhjpk3iD9Z2sJpDDPsZketfiwUwVGFdxelPm8QYMzMuptd/8yqoxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKlnEuSw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKlnEuSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DEAC19425
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 18:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776708166;
	bh=1l8v/fESj83GAnrDRzaGZx+a+AQ5uk+B6lt5KCjkDXY=;
	h=Date:From:To:Subject:From;
	b=oKlnEuSwLxZS+cGdPhKNFtvHEjb20iamQLiWC17P+5cTEHPI6qcvmKBCoaD9BeQqM
	 MUPBFeHJZl1UUhaUQJ8FxcvFs2SPw+3qI7A8Bz00VPNE1Zdlc3hs4OY9O8JBdmtV61
	 ovIY8i7xE+aM828ybGTnmBeXPkyTleQ+C/QkEQ6z94Z8QClODGhotJeLWmIQK6fO5F
	 3pdwoqTQc+UoF2XLklQAbLET8yH6Lb4g7z5ScOH4qu+U6qh6vKrgC5koxti0DjGMxj
	 3n8jgblTIfqYJ78q4I4mZDPn2rsKzdUUMafdVriJzR3hOZMOVz+bOSiT6PQTcSrxZQ
	 NyvpPCuPF779w==
Date: Mon, 20 Apr 2026 11:02:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev call - Apr 21st
Message-ID: <20260420110245.239b0241@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

I'd like to discuss evolution of the process which would prepare
us for the "AI age" (read: influx of plausibly looking yet entirely
computer generated patches).
