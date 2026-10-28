Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231068;
	b=XoGPhBVU9hFkJQ7Efx3pQBIv0MhBoVSYklAYX+b0Fc7gw60YBy3GS/JWGtKwevHExd+v
	 3JTp4ysT5OzwtFng0g9OS064FvJ2ZJjnmYntyIyc+NwqfmuIqxykmTIRcrDY57+hx+s9Z
	 NlRX0qig7JzYJ2mLivXEhb4H97EdnimPo5TtSdW41Zzkz4QfWHieATiYIR7WKr3q301iP
	 0T/MRuHBQONGdk6s4eXOWD1Sh+lXAMbSI7U/YzBEejsRMteZ/Jx7O2IC9hIiWGlg7hGYG
	 CVEDfHe+YsuYFWH9tFZUloRPsygXgxjfOkc9LMW0NOBkl7A4v8T93SDHNIsFpzeE15A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231068;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=G/mIuq50KwUHOK+88NpURS7yCuvBsGwSDF3DHCgRUrc=;
	b=xfUaeUNvgfpMS+2/yDDC8u7/elgI1fW5cUhp7cfEFUC05zfcMwJbop8rUlgUvCysHaAK
	 NYHQVwve44oDgGXlvjxZLG4LVeWWJTgcZT75vveG8sA2Fnrpohr6qyiDYK5to2lN0oz27
	 VKVW6ZJge4LW/tGLNoNsDzfDmf9h3BBMdTmwTWp7lxYJLkaG3xRi9kg7+1DlfSznhnqME
	 v6lrST6CvGCuEEZrwF+9zzjfqPyR68Qx9WBe+v/I/UHJOB3WGS3KhcTKHsRkj+oF3Iarn
	 n7sYtyGhfJmKbQhdgIbGaJlYJhmWEbrIlJOMdWWxixARtY1ZJg1+caNnqgZX7WXwADQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XFBKgbA6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555A606A31C;
	Wed, 28 Oct 2026 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XFBKgbA6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B12C1F01825;
	Wed, 28 Oct 2026 23:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793231067;
	bh=G/mIuq50KwUHOK+88NpURS7yCuvBsGwSDF3DHCgRUrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XFBKgbA6/6tPVvMoKG04Al0nl30KtzgtJ7kTCFnvCJZL6NVBncyx5iW3qo1QQTGCK
	 z30NhnsV8l0vvrZL4eBbDwtN11gFEH6rLLGUy3304G/gj0Gj3IT40HEkfVf3ZC3j4o
	 3HMwb6NuiELeiRQsUUP/C67gAtPTIzYmUxl7oqXMV5MEKbdu+ClPElEmqW4BTNSAR7
	 Wg4e3hkmM2CxMw8YqXk23DlXCuNJCh83t8aGtPbGx8/2AHcdCXo18btKkZQ0xAl9qr
	 17stJw9RPI2ci35uCNOo2QPS5Za6QfsWiZl4rB2Ifkm3s+Gu44D2rAHTREMWUkh1/x
	 M2ySQCGssKl1w==
Date: Wed, 28 Oct 2026 16:44:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: kmahammadraf <kmahammadraf@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Sunil Goutham
 <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, "Subbaraya Sundeep" <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Srujana Challa <schalla@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: skip CPT ctx flush command when no
 CPT LFs are attached
Message-ID: <20261028164426.4a58e2e7@kernel.org>
In-Reply-To: <20261026091001.3421476-1-kmahammadraf@marvell.com>
References: <20261026091001.3421476-1-kmahammadraf@marvell.com>
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

On Mon, 26 Oct 2026 09:10:01 +0000 kmahammadraf wrote:
> Signed-off-by: kmahammadraf <kmahammadraf@marvell.com>

need real name. Also need the reply to series bot in the commit msg.
if this is a fix where is the Fixes tag?
-- 
pw-bot: cr
