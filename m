Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D320A5CF;
	Mon,  2 Dec 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150292; cv=none; b=qRKEE0UDhX2UdDDe49ejLWjMKltOVSEDalPZhze2YdaSYR+f1Csre34CP2h2k+3wJ5qqy64Q5cirHIq6+CwiEImyj/xGkm5NvdRkiuvWfyI5WSNdgkYgclQoeeDxCYzBzg0pLxtoicUXzj9Ui80i/ZxsEb6zgj/qKevYJSW33Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150292; c=relaxed/simple;
	bh=gxQyty1ZjpHwP/s9IRJ+1UmAJOZ1LYzu7DRFWvclJJI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=eTQFpY3CBKSZmK5YP3hQCPUORe5pKsTuJ9r11G8GjE4NjTlEY6OQCBd8aBMWK76j0TFdsYtLvWZd4U9+WovS77gzRzZedV93ToPDBcCVD6GLotfaiU2R4p3WCXo2WQnQFrLodgA7IwtAoaJ63Ld4r0NhoGzHK5dHl8B2li2crEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rg8CnCay; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rg8CnCay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90D3C4CED1;
	Mon,  2 Dec 2024 14:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733150291;
	bh=gxQyty1ZjpHwP/s9IRJ+1UmAJOZ1LYzu7DRFWvclJJI=;
	h=Date:From:To:Subject:From;
	b=rg8CnCayafGCZsjb3SPwChC0FMq/0ebgzy+rv+Xg93BZZV6ZLr+yYOX+ZraBd8uRC
	 n/jPtKfvNe+gOmQd6TwBNFmW0iDe8sZOWBimetETtJnBdNawmbqzWGg4h75iNWQ77Q
	 d9PZDW6+EHw5MQGPM8leaqSFkxaVNikH1/nrIivv9TeGWyeasW+CB8fVD1VgTeXxrt
	 t5nwSUXfBiKo+Rpcg8X1F0UsJd3JW5pSKOe6aY81w2qIAco69wJsTLDRCtcHuf7D+y
	 ZrmHxT8DpXi2oI9LEZr4s8lLi+niMKJCEf0d6qVTl/JXuha32GBRDRZ7Coy+0aX3uS
	 RWBg8GD4XEp2A==
Date: Mon, 2 Dec 2024 06:38:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] no netdev call tomorrow
Message-ID: <20241202063810.163610d8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Please speak up if there are any topics that need to be discussed
tomorrow, I don't have any. If nobody speaks up the call will be
canceled.
