Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A3238166;
	Wed, 29 Jul 2026 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286164; cv=none; b=BHQzdfcV6u/Z3qJU9UEAXI4799HpHQS5syp5wXHTKAMGoNMamnkYCXuku1z64w6sV4Np9J+JHkDAq2docDZ18yumZkIQsd0xPbMpuUVmxPQ35MP2c8MrHQRb1kPQZFQMPxfxI4tzmQQUlghvlQO1IH7elItqUVNax3+2o9TfiGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286164; c=relaxed/simple;
	bh=xoJGtND626UWEWmxoA3fheCnQHlT+Y4luHK5UydBsyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQ1hFjF9sepYh0dppvyl85z6xFMqSCuIYoxAR346oeAiPSM3GG0EwW+s/WdHrheUyl3E9Qrlf7CJIhZKRXkQEudQlTrT4a8GVhFjs2M+Zrw4+TyTTS3O6TrPloFJ1j47JSF1o/aYvLsFy0jQ1IhV90VX4yJzGWzcLvxRgthOZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d08+wsIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d08+wsIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CF21F000E9;
	Wed, 29 Jul 2026 00:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785286162;
	bh=xoJGtND626UWEWmxoA3fheCnQHlT+Y4luHK5UydBsyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d08+wsIUlf8pCCbbjwvJ6v/kZPmM2r15j4/17T/5MGSxx7o5QP81p6LhZQzIZRVFD
	 SZ3RI/YQmllzKTkNLHDKjbeL99lIZKlR5ASbEskO17dE6eIiTlloFKmBZdMa1zN+nO
	 pNiLFhwPbc0Y4ETZ6ooiap6jOGW6YMRSAsrN3dJvtjXHKBmCWlJC2hAgf/Ve+Qsbhj
	 70zlJx4B2xO4gBTbWMUAKtznRqv4V7yKkPncFYqM8svKong7xntU1Z7AGzYKUmXe+m
	 b1mIX3tu/+7qmZW727zQKjnKbOOpMntPK+7tpj/+TXMWyAN6ZxoMin7lcyIl265LVe
	 GTuC6Qhyxwibg==
Date: Tue, 28 Jul 2026 17:49:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <han.junyang@zte.com.cn>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <ran.ming@zte.com.cn>, <han.chengfei@zte.com.cn>,
 <zhang.yanze@zte.com.cn>
Subject: Re: [PATCH net-next v9 2/2] dinghai: add hardware register access
 and PCI  capability scanning
Message-ID: <20260728174921.1db84efe@kernel.org>
In-Reply-To: <202607201814508607WgwfRziVS5D44YN2_V69@zte.com.cn>
References: <20260720180651288d3b9DAp__Lfvo2x2PkMfC@zte.com.cn>
	<202607201814508607WgwfRziVS5D44YN2_V69@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 18:14:50 +0800 (CST) han.junyang@zte.com.cn wrote:
> Implement PCI configuration space access, BAR mapping, capability
> scanning (common/notify/device), and hardware queue register
> definitions for DingHai PF device.

Sashiko has a bunch of complaints about bounds checking here.
My understanding is that we don't have to worry about malicious
PFs but please double check if any of the complains are worth
addressing

https://sashiko.dev/#/patchset/20260720180651288d3b9DAp__Lfvo2x2PkMfC%40zte.com.cn
