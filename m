Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BEB218AD4;
	Wed, 11 Feb 2026 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770834790; cv=none; b=LLFIAaoCJ3XsQGzwXJbvxtowvR6sc+Ujk2PG2eam4E9O2hMZ2+cZnGg5ioYN+wItJSV++6PV3Fm0ol8DcZ0XNjU31oVBpB+DQNQrBs3rzWPOXD64PsJU+buXMFDtx1IBGiguVjbyOgsnOH/4QGP5ibsBvkTFZOnrBxc3rAX72Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770834790; c=relaxed/simple;
	bh=mZP0ZcamCPYPrrchhEROGUqFskEb/J1RdkXJkFb4IF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPE9gRcceRRAGKlWALcInJvH7JlT6FIsNjOKnf5ptX1nZPrVRojYsy7BbDIVRPgwr4slPNOkD7omgI9pnlacww4OaCE0g7azKhFSx2vHhayjRyUDxu43thAZtWEEFLFoN0jR1jcO7YzNUZhNRjVaUxR0jPcX7Okts/dSmbVQPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Asa0mqKT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Asa0mqKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DADC4CEF7;
	Wed, 11 Feb 2026 18:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770834789;
	bh=mZP0ZcamCPYPrrchhEROGUqFskEb/J1RdkXJkFb4IF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Asa0mqKTxGp406VXiE7/IFaRBva8CsilaXHF7OBK9Nz/9I2FmLIC+k0D7AJHYb1mU
	 V9OTRGe1CF2bFO0PSihKGhrdos+z/mZ/hhHhqqY9kBDJ0Xt38nbkjzqI6OJhsx762s
	 uPemOWEzWztq1fQ+mh8sfiEnEKC2AHQ4S/JdukU+7TH47vQ6TJ57//csNxE5q86/H5
	 Brdo6Yl1Dx0/2ZY+W5D+shZaJwmUcRTKgKCV5YJDBRFCqKPYa9la3TXTqJkcD+j3Xs
	 6zBsIGESQaOtiXcQ4bmSn55+NUhWEwJHOFg3uC/3g3jmbFhm4qxdRTJCjDcYN6akKO
	 hSRXMwmyej00g==
Date: Wed, 11 Feb 2026 10:33:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mingo@kernel.org, tglx@kernel.org, dave.jiang@intel.com,
 lukas@wunner.de, arnd@arndb.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] myri10ge: Convert comma to semicolon
Message-ID: <20260211103308.4d6263bf@kernel.org>
In-Reply-To: <20260210013733.1901270-1-nichen@iscas.ac.cn>
References: <20260210013733.1901270-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 09:37:33 +0800 Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.0,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 23rd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

