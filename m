Received: from mta1.migadu.com (out-118.mta1.migadu.com [95.215.58.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395E38A736
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786833568; cv=none; b=uSYSD49abQZK0xsvDhXlzaxlkvGkVGHPESUPw8MVfKCv1GU5UsczWdpeGhQXwgUIgpqiIFoHwJqo+IqwOb/c3qK7hPE33BqiIA+K4xmE78p83F0HnAJ17dbg7W7m8AFbx+rK88HGtyZOi7JPqb4jghfgbnjR7N1DUWi3eY6U57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786833568; c=relaxed/simple;
	bh=6sAce1AaUntUrsQuBJyyhuwML2qhFg+AQ+YsAFYRVH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixZ+3oJvGeTcp6TubduYNsmMs33e4kKRKhGic5FKCq4zTCMvXppBRbAhdo048TkT63EbRYjiIfKd7pE71vBCYblcXQ1wSICrnvi01AfnGnk7wcMwcTWU59/Jpa3/a0GD4oxOEiTA5NF7JiQVnY0t6w88hcqmWrWQbrLosutIm2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d/+E/Yds; arc=none smtp.client-ip=95.215.58.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d/+E/Yds"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6sAce1AaUntUrsQuBJyyhuwML2qhFg+AQ+YsAFYRVH8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786833563; v=1; x=1787438363;
 b=d/+E/Ydsyz836iGLjHx2UR0Gpdv5Ad2wBdhI7MlE5seEvvL+ZdF9qiBdySziAlu2y7whRcDp
 TItOi9PC+LWrOXeMe04pLalqPc4ExV06SgcMnQodfdZsit1y37rs+kb9lNSKJs2AToXgZ506NKL
 9UdfnH9F5SbZ/OF3HiLS/Nng=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.1.24] (78.152.211.167)
	by smtp.migadu.com with ESMTPS id cd1a1a8c91c184b7;
	Sat, 15 Aug 2026 22:39:23 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <f124f74f-bef6-4e0a-b927-2c2b5b67bea3@linux.dev>
Date: Sat, 15 Aug 2026 23:39:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] ionic: check for a NULL port_info in the
 remaining ethtool ops
To: Eric Joyner <eric.joyner@amd.com>, netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
References: <20260814-ionic-port-info-lifetime-v1-0-f73b1a06c5f6@amd.com>
 <20260814-ionic-port-info-lifetime-v1-1-f73b1a06c5f6@amd.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260814-ionic-port-info-lifetime-v1-1-f73b1a06c5f6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2026 01:00, Eric Joyner wrote:
> port_info is a coherent DMA buffer that the firmware keeps up to date.
> ionic_port_init() frees it and sets idev->port_info to NULL when the
> device command to initialize the port fails, and that failure path can
> run while the netdev is still registered:
> 
>    ionic_lif_deferred_work()
>     -> ionic_lif_handle_fw_up()
>         -> ionic_port_init()
> 
>    ionic_reset_done()
>     -> ionic_setup_one()
>         -> ionic_port_init()
> 
> ionic_get_link_ext_stats() and ionic_get_link_ksettings() already test
> the pointer before using it, but the rest of the ethtool ops dereference
> it blindly, so an unprivileged "ethtool --show-fec eth0" can oops after
> a failed firmware recovery.
> 
> Add the same check to the ops that were missing it.
> 
> Fixes: c672412f6172 ("ionic: remove lifs on fw reset")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
> ---
>   .../net/ethernet/pensando/ionic/ionic_ethtool.c    | 30 ++++++++++++++++++++++
>   1 file changed, 30 insertions(+)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
