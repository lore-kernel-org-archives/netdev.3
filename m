Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137125CC73;
	Mon,  9 Jun 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479646; cv=none; b=NbIU0NWLbrOzRo7TgT2JGmfWQv2Gfq8qPWkmySfkejmsouf1JqgaXeKOBX4j1k2PymNFpAWuLmosXd3CPgfqhZVm+NQBogjuxY/awU+WRC12sg7v6fTqezz3wkE1UlMAunKohq71Jwa8QP5GMPYN+S+W4oaSlXNM59hJG8DP+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479646; c=relaxed/simple;
	bh=sLvm7NoZYq6spqrG/F1yV4DJ0vlRdj63ek11JyM+Gk4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=AT/HJBpqp0gxWbcafHyGe3FQiT9lfF59vPPgPBQ1RK+b7krPfPK4zJOL2abKfZmpNZNPsvikXqYTR//uS6FXWS5gmZMoIAdLYZKkshfzs5tpsmalauMdV1HtIsT5AX3xvkdNwTpaArE95epbABqMAKYtxveJuyLbRBVpvwGQc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbAtETC9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbAtETC9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0701CC4CEEB;
	Mon,  9 Jun 2025 14:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749479646;
	bh=sLvm7NoZYq6spqrG/F1yV4DJ0vlRdj63ek11JyM+Gk4=;
	h=Date:From:To:Subject:From;
	b=KbAtETC9zFuxkrpvHoAjhKspDAjp02vJbFaSZiXBg5KKfAMdL/ijzy8j3fdtE5Tkz
	 9X4JVE/CgbYAw6LopJcLwQFYOtyVLrAO5xMu8hbDMa6Wckehg5JBPcKatTTLL1Z5Ft
	 2Bs0BvmtJvYwl8KLoAx8E2oIwGDBUcfj6afZ63WinCvoU9OeXlEWpniw+rkVSbOiKc
	 XaJr+Bm4jcB63u82F1Q5Bh1BWGtmciNEaWGZ7Cw9pbGGJx9axPd0Fd+iGRH9CoOHhB
	 1rtJp+w1wM8dXiI6I+6Njb0HSbHJ3l4nqApnO/woIarvGX0Ec15AJ99fsBXj7Uj8eJ
	 S7I5uUuse8rcA==
Date: Mon, 9 Jun 2025 07:34:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20250609073405.4f2a8334@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

net-next is now open again.
