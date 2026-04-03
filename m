Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A8B37F8BD;
	Fri,  3 Apr 2026 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257001; cv=none; b=ev3ChiR05d5OeXWce4m1ycHn7yAzOto9XJZqgm50CvS1+jW+TmoVBbOn8lAwQwKs4xRCGSuYk36KgVInnimmli+LqHHnr2eSlvyDDyeqr0347PkBaDlMHZ1Quonoe2vtl4NW/RzTOKgd9tCbVQSbRlcsDl12kTWiHc5LX+wITFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257001; c=relaxed/simple;
	bh=hXq5aKe1Bem1EjkPLh96GCcPtlZZFtOa8gsnFEtE9fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kg0O5+r4okajKAXJnM5VEhR/UjmV5KAkV9ebLQ2TNzl/PPrdP4wWa9WhUajLaCfTHiIQU5+VXXshIr9SdbpkoqAX3lElhjm4g10JUs+zYTJpPIamFoqGy2xB4wAaiuldHBAt4chotWHNWVA+9semoI3jDnIgC2VyBc8oBZT6lgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlX/pWjY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlX/pWjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A246BC4CEF7;
	Fri,  3 Apr 2026 22:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775257001;
	bh=hXq5aKe1Bem1EjkPLh96GCcPtlZZFtOa8gsnFEtE9fQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TlX/pWjYBi4ELtTm+x8LTUEKEMdZb4Rq4UFZcWyAK8/KqYkKj9VHDd5scvx+Qsed9
	 v3QfTJJuRT0bv3QDFuW+a9hmIx3VmPocTI/4c6KsyLWSJeskksVkOAiSFB6if5gH02
	 LDJFcFQUhYlP1knIIxqALo9GlqY8PP0EWPWGME5KOnloDuRg0vUR5V70fbswH+p1Ye
	 Sea/4R6BoNpmMQ/BiDxLt8s2ptV/y6fG6tM3Asiz+ByteQVYKW5ukeOHTVpsOMAOLk
	 UQmCoOQVDMpCYrTvGpt+Gcf2N2xj862F37zhKRm2GIPwgZZyJgGywc0Y61zfZ6pI3f
	 d/tiqAt3CWb4Q==
Date: Fri, 3 Apr 2026 15:56:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: netdev@vger.kernel.org, Lars Poeschel <poeschel@lemonage.de>, Duoming
 Zhou <duoming@zju.edu.cn>, Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nfc: pn533: allocate rx skb before consuming bytes
Message-ID: <20260403155639.070b4243@kernel.org>
In-Reply-To: <20260402042148.65251-1-pengpeng@iscas.ac.cn>
References: <20260402042148.65251-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Apr 2026 12:21:48 +0800 Pengpeng Hou wrote:
> pn532_receive_buf() reports the number of accepted bytes to the serdev
> core. The current code consumes bytes into recv_skb and may already
> hand a complete frame to pn533_recv_frame() before allocating a fresh
> receive buffer.

no longer applies, please rebase on net/main
-- 
pw-bot: cr
