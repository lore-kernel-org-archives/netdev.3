Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13652E22B5;
	Mon, 16 Feb 2026 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771273320; cv=none; b=qvGISu28YLb4eBXSzFJwFCFRCZ6T0a58yqZpnWmsqPCj3bGM2+WYW5bsQ9Wh2MiZroqxfptwq0ZV1nmhS/CbKGcZrYZUbt1QLhJqqodNppUGtDHKyrngIQPra1Cumpr7U/b9ElCvjc7Dk4PCPahe5J18qulcmr/d4ltlFqDCBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771273320; c=relaxed/simple;
	bh=i/njuAwIIlHN67tm3b4SyqKsCR5KnzOIE7TbVsSRq/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwsC30LqJDDgpdQ4X0QV7gb7Q+Oj05a242rTRrLvi9UldqAfA0eqKKYhZBjd7fprvLqP7AUiktPlMsjAVZjGaRzKFYHQ4YYanksCo1L4LZUNAKqglj64yttK8xyfjJSpHnFCV7BxgEClh6TkuEW0noT/vYCOJcnSw0CzA0t3qXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ALxmtIkg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ALxmtIkg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=sgq3DEY4sfVv45q1ksreQHAfcaX+hCQ8IiejSVMHmfw=; b=ALxmtIkgHb0LLQ9026xxTHCA7w
	oDQYHFSz6FjRpR3DNi+SIs4L/dMcA65DcVB1L637qRYjhxKYa4XpY6op6H/ypP28sUTih+D2SXVdG
	Fp+KVYTtv+wUy/6eD7UD5ZGb5UUsRYZxM0mXWmlCwd/8ILRHiWUqYGPzTfHhC+6c6cz8H2RQHwJkA
	We5aZrgpwVgEgCEKwBHUR4NVUUwjC8ThohyYVnuYCvkS+PvusGC5z0DYZsXfCmEAPSVgpxAzU4QyQ
	vcTmcXt9dLkM9dkTGOyP72xRiG8S3IpZNNGuTDhVg22+HLcgQ+qJHD+RJxpGpeAt15eBP95cPVLz3
	/MTupUfw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs56K-00000007FW8-3t82;
	Mon, 16 Feb 2026 20:21:48 +0000
Message-ID: <1f0bf8ac-d61f-411b-ab49-3785e069e528@infradead.org>
Date: Mon, 16 Feb 2026 12:21:47 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock: document namespace mode sysctls
To: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Bobby Eshleman <bobbyeshleman@meta.com>, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260216163147.236844-1-sgarzare@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260216163147.236844-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/16/26 8:31 AM, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> Add documentation for the vsock per-namespace sysctls (`ns_mode` and
> `child_ns_mode`) to Documentation/admin-guide/sysctl/net.rst.
> These sysctls were introduced by by commit eafb64f40ca4 ("vsock: add
> netns to vsock core").
> 
> Document the two namespace modes (`global` and `local`), the
> inheritance behavior of `child_ns_mode`, and the restriction preventing
> local namespaces from setting `child_ns_mode` to `global`.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---

>  Documentation/admin-guide/sysctl/net.rst | 52 +++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 2 deletions(-)

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy
