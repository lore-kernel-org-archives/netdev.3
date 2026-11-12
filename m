Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503605;
	b=H1AP/3qrps8IjqvY1xuQfq8hR5tkSx9w/HWS1V9XUUzVhrqk//2Zkv5Yb9I9oiVZrweH
	 TDbi7mVU3GQRdtWSdBFBdnmz7lKQj0pgvJKxpBg+JgDs4QE2+igD0uMNr1nEz+OKCzldB
	 W2cs3b8oX2N/coDu+eP09Wo/2IYSS0xJLXhyxJ3cAn2XQ0PxPyqGL6d1IRxp7OPCeIQk5
	 2eI0UtRqz25PJNwKwBQooMqI1skF/6VnCrptSbKnknZIyGy+wPRyiKmwwlcjKVmCJNQ2n
	 vQ3yiZ/hfadHldcO4hmLFeDGi3uBBxxhJSCn2tPNqENNMdueVr6Q5EI3Mau0WUdeFAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503605;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vWaZm7d2LOmd4SEfSP1fogxAuCjGJmKIM7Cu5gK5wxA=;
	b=so4Z+JdDvGQm6o1Sx3QfwKPbFJ8g5LFj+CNXg2kYc2VUy2kVJ7KtB5qMrCdxiZ6OaTlD
	 NZ8VP5ZlRhkGGdt+SUuAhNWRIhGGJkSuBxjPj4L+8bUbf8gW5Zc2nYvqt/BOyGVNRkljq
	 IEgU1Lf4OROlWJbRGupZrFFGiy2Twcwo3NjQTHiSh2ZtQ5WbhV/9W1+hyBqeab1mYY4gc
	 dfUDeQ5k1hqaSZbf95IWBjaQpC37uoPHZVfSZeUoNcGZgRUOFof4OjzJYmZkU6N20Mbwz
	 xCtlhk4xM8TdjUubkMhly0DIxbcdWmSNPLTv0XVpyWpCmydK7oOlk8+7cya6jJCqCmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOUdZ2bE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0218F606A327;
	Thu, 12 Nov 2026 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOUdZ2bE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB7E1F000C8;
	Thu, 12 Nov 2026 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503604;
	bh=vWaZm7d2LOmd4SEfSP1fogxAuCjGJmKIM7Cu5gK5wxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JOUdZ2bESrmtNlxYjpDokiP7Zh3xcVjEL6tLovHQ110QOq8vAin2LO8UwkBWYeDto
	 myrm92+9JicipXy5aZktxFOi6xajBBpzbE5U+KqnsOTdaLaISDgVoY/43fNTgO/NVS
	 mSq6tNpxK/T/I8NG6Jwv7TrLIJiRctGUivd9pWRkc9KxtQFpgVqRoTK1bWQssbEwfM
	 BPRIM6Mt5JYZciR+jXMFYxqk2lbV6SXEhWKrzEWulKrrVaKOXAAttJ2vQLtWIMj1f2
	 Qsb5NZbOJULE1ppYdxALJrgAs9v1aUV0SW8T54rgkVpVzbZDiGjb5F1QY4mNiGUe5r
	 qTbJYEubrBbVQ==
Date: Thu, 12 Nov 2026 09:13:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Kordian Chmielewski (mlody1212)" <kudzo51@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli
 <florian.fainelli@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, bcm-kernel-feedback-list@broadcom.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/7] net: bcm4908_enet: TX ring and DMA fixes
Message-ID: <20261112091323.3c685f8e@kernel.org>
In-Reply-To: <20261112132308.340291-1-kudzo51@gmail.com>
References: <20261109235700.2586821-1-kudzo51@gmail.com>
	<20261112132308.340291-1-kudzo51@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 14:23:08 +0100 Kordian Chmielewski (mlody1212)
wrote:
> I will send a v2 with these fixed.

The AI review just got posted, please make sure you look thru it before
sending v2.
