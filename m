Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6136493F
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 02:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780624909; cv=none; b=MNE5naiTZ89Jjwo7nhjdVROGJ6DYrJSGb6WmIhC7TIMCfM5P2fnziaRqjJjVGU+g7m61XWsSsqz4USjKDiAQyswwtP1FTwNcE8aZ3Tw8tZBkvLCkdr1YLZCC49gXNpqp2jHZyToPhFAfcWfa2dfrbRQOy0hXNgYYTTszLy2Hm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780624909; c=relaxed/simple;
	bh=LLmQk/fAGaFis3s5YQoxAFKusr+v4hOtjqfghPcTyI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbBvwv/EVLnPVOCRRavceygH1IEjnMl2dRCPto6UpQ22sBl4YwlFX4L9l6LkLsGdODrVZMBHUbrk/jr4Aj/UBBd0DpwXYYv8s9hH4UqeIWQr77zjVXsmwy2vZdeigs4ZXzdipV9tGQZ41MxI5043CmK+nuJ/thHWFLheWXSzpeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtUSOQS9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtUSOQS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C281F00893;
	Fri,  5 Jun 2026 02:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780624903;
	bh=pKHwinsi5Lypn1fkSdH2aiWKw9t4V2Hlvbu40fHCDok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AtUSOQS9klYTHlFeR/Ql9Oj5tk1ey6o50pHsP3yWqORfv+U9bLY8skGcVMAcRTCxp
	 cKJdP/s9cV+yTNiS4mIvtCImWyT+zuW47wmqaRCFbyXMWgU+TIeus6X8d67HLkl+Cu
	 DRjZ8VwRCgOHKLML2wkpxRdl7r/1nuvmVkvjU/g5QoKpKIzGgWdVhIYEOjTMkGyj/H
	 LKDCSdmJ++kOQ4ItjmFEZsrOnA/dClawxMdeaecd9U/5qss+9dh2X1SOwWDzD5fNt0
	 1TRWP9uyXg6lwqDGaTCd2WwTWqI1xMwymZwTaWtJ0kWdPqzgxXPCx4xCcGVhYTMppy
	 JxfK3KLzZgItw==
Date: Thu, 4 Jun 2026 19:01:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/3] net: add retry mechanism to
 ndo_set_rx_mode_async
Message-ID: <20260604190142.0ef0d119@kernel.org>
In-Reply-To: <20260603223535.2504695-3-sdf@fomichev.me>
References: <20260603223535.2504695-1-sdf@fomichev.me>
	<20260603223535.2504695-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jun 2026 15:35:34 -0700 Stanislav Fomichev wrote:
> +	netdev_ops_assert_locked(dev);

One thing, I guess, since I applied the rename I think this should
become netdev_assert_locked_ops_compat(). Not that it matters in
practice.
