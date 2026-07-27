Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E392E3F6C4B;
	Mon, 27 Jul 2026 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192964; cv=none; b=lB96qxtXjdxxUMByyOpnTiDQNkvERirVrWBWkPmcH+ObUDAsHdYenQEzBIsKIxTNvLSCa4mzS+sCnWTP7J+pocu4JqdRVMeNzx46uJELD8mdL3ErwwLng4it7erTPtNDhu8UdEcTOEFSZ/yb9egtHEajjRAidE9ic1ioBteQfCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192964; c=relaxed/simple;
	bh=+fEV1lA6PmyGpHeQTFwEiucIkiPC/VnRHe7RcfKKN0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXkBGzaAfMOH+Sl3vFGrmug0n7aEkQS0Af1BOIxzB62R7RjDr/YC+C78s15DNDouVg5GmodEAalI488DD/+mXu4lkVrwiVS1cWuIOUflRbRyf9QBTiHfwp4kna4kztPkngMus/0LpV50JBxeab19CbEZ91Y127nxxOvESemkm14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHt5/g7W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHt5/g7W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E44F1F00A3A;
	Mon, 27 Jul 2026 22:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192963;
	bh=EW5+7tTJb5dzc5qFpRMJAhjHcBQf0VpCGZYjBGHX1ZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LHt5/g7Wqe8LqdXjUvth1AtnzcUFKW4KMPrTUREscZI2rZtwqBFVf5dmiyCjk3PBh
	 wxL0Ic8KU0PHteRV2yv9VN6CHOrIAAF7eUbMhWnGV3Uu21v5jZMrhNIoth+/hQRLNh
	 skzD29RnmNJiLOSAdldlcYGusA/bK5qysRWQ04JFtoLei0eFTqj3WLTjJ/bPenaRck
	 q1Rb/rYvhifgVT9pKjfJQlUGHoDYKKyVqlwCTDttut/Jzrv2Sib1o3ipi2dmpf33N6
	 SF4SQsvambNTNcK6Gmwf1qi9I/PGsafRS6Tx82qB4eipzjJbVfWf6DqctVms90WmkW
	 OXnkEwgcy7m7w==
Date: Mon, 27 Jul 2026 15:56:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "shaikh.kamal" <shaikhkamal2012@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Matthieu Baerts
 (NGI0)" <matttbe@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] netlink: specs: nl80211: fix TOOD -> TODO
Message-ID: <20260727155602.0d7cd199@kernel.org>
In-Reply-To: <20260726055046.18029-1-shaikhkamal2012@gmail.com>
References: <20260726055046.18029-1-shaikhkamal2012@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 11:20:46 +0530 shaikh.kamal wrote:
> Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>

Format your name properly if you want to be taken seriously
-- 
pw-bot: cr
