Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A6B24501D;
	Thu,  6 Aug 2026 02:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983242; cv=none; b=RlThe579flLPyIr0M5hnq3sHjZqRuAfKuoNDRSggR5a1rgosvgbllEgyD/4iw6cgCD7A4R3Q9gDngWA/4etciJFO4AVm24167EeI/1yf4TVTw7j+Byq/VK7oiDPgJSE2p6uzEpylRLypAhFLeTPvVDfm8l+h5qzaM5pemnMU8p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983242; c=relaxed/simple;
	bh=YtCJ5SsRpPBSQ+MXB5wcKcfelVvY0AKNgMKUVYF/zFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qi164XiSd44coEs8/KejnpLbpivcyWsdJ1V3X+ezEM7Um3O/U/Cs0ybWtdi30pPcIIBQ7YZAdvd/ZJFgPFf/CPTHsz39mpZwsHUTFPoBqC12S0wYhrn74tnW0+mpsNdFqtI0pO6N2sDVonGQvQqaVuC3esBzOiRFmxJUNngskqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPBnuGze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPBnuGze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB1F1F000E9;
	Thu,  6 Aug 2026 02:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785983241;
	bh=qwH5CR6eL+Douq4vuseN2ZC6QOu68xpXtt7+jfLX+Ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VPBnuGzeG7vz0eF4A1zwMkKnPk5BwghrKPuuApTL7oYrYrY8Du/WgfiEemnePTZlS
	 HOktoDnAxH3avwbhLec65Aa1qwmiZpz68wlLdCAPNXesYto3ID4LYczhghfgjXXtE1
	 i4k4oOX603yZcyO4vNTP8yveILz13yhfgOBoYcjDoKYzRCIi2aAzJ3kyUqxSzaKBWg
	 QA9fQvudcRpNHtfT1PWvsQ0o2XnZXFsu0YVsQGSs2cxnUU0CZoBQgNAWOYHMaJVglX
	 yT0dXkgIQWLeTTztzZvoKUN8I6mBkYp5C+c4PJXyja0dJeu7cwZHOXBeJX7O4L8EDW
	 9Ue+LZn9GZfSA==
Date: Wed, 5 Aug 2026 19:27:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, 13667453960@163.com
Subject: Re: [PATCH net 0/2] Fix ref_tracker warnings at boot
Message-ID: <20260805192720.1373c514@kernel.org>
In-Reply-To: <20260731035135.3917308-1-yijiangshan@kylinos.cn>
References: <20260731035135.3917308-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 11:51:33 +0800 Jiangshan Yi wrote:
> This series fixes two ref_tracker warnings that appear at boot on
> both TCG and KVM:
> 
>   WARNING: lib/ref_tracker.c:322 at ref_tracker_free
>   WARNING: lib/ref_tracker.c:246 at ref_tracker_dir_exit

Thanks for the report, I've been siting on a fix for this.
Let me send mine out.
