Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECC74D9F74
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543631; cv=none; b=XBym13ObMHXQyMiV/9YOndnwxn/jvRxMEUt3ec924w5exMKQjsGdJCT9PuCI2AA2fnItRaaG2CV9oCULpXnoyNBtv8rC4AXdp79m9GNG/gxESZfGlUBxzEEMG1Zii/SbsaxMaCi4X8HPsHKBz7WtcOlARoVWMQlbWJeNzbWy108=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543631; c=relaxed/simple;
	bh=BzTR+eW3wr+Q5y1uCczUoND6CTvbG2LHZM1vzpnFyMQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X8/vW020oRlmAbYxDm7+TMAUOSgE7ijwHOxXqBKGVqBxra/5yi9ktGs+0PjN2+PyLsiq10KMHwmT3l7C3sAD7XOuEqiHG68GOx4BizRqwaTrAYz4MbqXe9uhYT+gKL4h2y925S75wQA+bUvs2jWhMdYJO/IgDf1suYy0p4q7sTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=CjLJttJm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dC7i3GMM; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="CjLJttJm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dC7i3GMM"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C3771D000E5
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 07:00:17 -0400 (EDT)
Received: from ams-imap-19 ([10.64.2.39])
  by ams-compute-01.internal (MEProxy); Fri, 09 Oct 2026 07:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791543609;
	 x=1791630009; bh=HRdD7XbZXfyzgNKs4mc5etqpgg+xB3vrcZQ8CfVm7gc=; b=
	CjLJttJmjx3XadfMokRx9zb5US/ORFjESN64jW+QB8DM8wExJObwGrJpy7jwgwwm
	+ga+J/sIWudj+LXVqY/rI4IR/gwdIHSWeMnZMNyj+vsUCbHN2u5zt6Ig83rCgVgV
	7lgTcXtLvOQ6LhHm5YUSO5zqGt6Qinziif9WwDY6CPsjO231+PDalxqLfzlvdHxR
	lIkhVoeShf8OX7fq/yw38DBg4sTJPi/dW7bJtHiF/EzzenPOMYbjeze1ZXtrjTT6
	smmNNqDyrJ5DXqFSO9B7rM3ZHBDm1+G95fq57rHzdSoFdB6ViBSwJKubu7o1etIw
	LzSBmAyCikUgfRYqc0jaPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791543609; x=
	1791630009; bh=HRdD7XbZXfyzgNKs4mc5etqpgg+xB3vrcZQ8CfVm7gc=; b=d
	C7i3GMM7HhJRN+1T+7EBZmPOoYzlPnW3rMSHfs5urfxUR0n3YSzYF3pFOWYXZp5E
	J7tKOnGV+LJ+uR2KZsoF9Kjm8b0/NzaQLqE/Fd8JWppvk3/NLqIbd/O2PWJ/QOiF
	VPuukP7igAAhsgDW0uu0fI/0w7Bh4wjJEh1/7r75e7NQO5KfgAaWs17dbB3W+rnk
	JcYe9D/qiX3HbRLtkmoNoxRoGhQmF37HWCVbd0aFoUFX8ePnMVKCx2U5KoTtV7ta
	cHZO59AcWMZ3QneiU4qbq1BbsHtmfDIYIxljxqMga24ecQbptR8BKhPX6zlOwkCi
	WUBd5bqhSrIV7hsVXIS9g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791543609; d=fastmail.im;
	mf=PGFsaWNlLmtlcm5lbEBmYXN0bWFpbC5pbT4=;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lVhNeHZpDCmy51Ioa3BfdjvmJ72AKz5+HIz6rXmaLZssLRR
	iNjReQY0Ggc+tRNUo23PZW6FxKuxskc/Gg3/OBzP2ba9QD3hVfr1EgNvObVhbnn+
	ScJNYFiwLH85L1xOK3i8AR5eZCwln4GEWZoT13ck9itz4zkWOpEPPH6zOkW3fBfi
	iYw+0LTkIpU9mUvoyqKm86yZg81w4AaOfykBZlr4rVcT88xoawUoOqhpsWkOi2oU
	zsYtcLe4sYxh3qCquZ9uvBi9eNw0JoR0CVh7JqGs9ZMsrFW2oOHAAxyJo5rFErVh
	vTanuwGZTpXExXFbAYwZEmsOtiSU+CGdLYTZKhw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cqRdEF7vO4dqzT6dpUZoD2031PsWjeHqBGUfWzYnXCQ=:BzTR+eW3wr+Q5y1uCczUoND6CTvbG2LHZM1vzpnFyMQ=;
X-ME-Sender: <xms:NMnIanT_oa-UGuY0gfsUMaz-qIxMOfoCBA_yWHa4v9wndCvsmb_aAQ>
    <xme:NMnIajnQ-kUNy3CapMgiEWi2clOfwa7d3B_LlY-lEwMy6FmXM6BAJ3BbYxcb8lwXi
    B-lN9NyXE3QVz_-SrBmhTIMvANgVCC0WNoNpjTZaToD2Bj-iGB3LLza>
X-ME-Proxy-Cause: dmFkZTGbB7RwK4ypT1uHKC2/+ph+7+jcr4ZMRMlp7fXeuD3uWp4EYF7LWsyYq9zHwHNTEN
    k3IJQPb9bjw4BStTNk6RSUiaWikop7jTY/d2J8xv0G0tKcgzXFkUvRLj+as9vmc8AkBtpT
    8S/KiiVMTpjJbGUM6jgjmbjemqaKq9h0UHqqLk3RiqlItkHOZY1lcktcIchZ3AlzHgaNIW
    Tc3D04DAGmQKEut5QUlot1SdewWFLtxPBlvVaKTZUBcJABM58IkmPSdX/FSBq0qqXEglme
    mmNPQrSIoWPfCFlnhZn15Yd7bx3LJqjKYnX636c2SbfkwgH2JDt5MJGPjFm/y5ykMjemEL
    g21+N38EtqlzdPeDruhcs8brdwmBvP2xTzA2nlPM/R1k7j2XZpE+1wqnFWVOxgvARrUjsl
    Qa/mT0thdy4Ga28yqijywE8zYbI5GsenoUnEeh3Jfsh2Ng6d0EKwak9NCl6w6/oBaDGCmV
    26oj9QWAaYI1drg2sgvlOX2+++qce1vaugKYq3P1MsksHjiLO2t8kdvkzUJzy2MFn432aN
    x47mEyphBgUUGwnx2xuQbK21aOqz0IXBu8mrUDDtaAmJ85EFBB1nKiaKTJhg0awldA0KlW
    0vBGTx5RzPOYWW4eh+jCxrppA3wu8S7xn9M9wfcUn9sW869Qvad1YZAgMIbg
X-ME-Proxy: <xmx:NsnIaj1m2CpLMi1ESMQpjdTsQBaKN8MOPlxOcB4-siAf5pnNLy-SvA>
    <xmx:NsnIajqT6AJGKeT5EydclvNiQMcD4B649qoEb7-A2rrLBGQWD0bYdA>
    <xmx:NsnIajJiT32hKKJmhZ7UHZn1XYZvfjvM8mUURnY1CTOU-W_goWUjrA>
    <xmx:NsnIavSMHLqzqmkz1qSFAPMCGE3ioew4F-0M5_RNn3gsHnDQmiQGnA>
    <xmx:OcnIannhju_zvyOEktgLshhr98im-EPeRF1bktUzMOF35N6KQZfDnQ-->
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 478222F8005D; Fri,  9 Oct 2026 07:00:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 09 Oct 2026 13:59:43 +0300
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Haishuang Yan" <yanhaishuang@cmss.chinamobile.com>,
 netdev@vger.kernel.org
Cc: "Matthieu Baerts" <matttbe@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <a300a06d-89d0-4977-95aa-a0b3d375a8b4@app.fastmail.com>
In-Reply-To: <20261007014731.1277055-1-yanhaishuang@cmss.chinamobile.com>
References: <20261007014731.1277055-1-yanhaishuang@cmss.chinamobile.com>
Subject: Re: [PATCH net] selftests: net: big_tcp_tunnels: Fix the IPv6 route change
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 7, 2026, at 04:47, Haishuang Yan wrote:
> On slow machines, do_test() raises initcwnd on the route into the tunnel
> with "ip route change". For IPv6 traffic this fails with:
>
>   RTNETLINK answers: No such file or directory

Thanks for the fix! It's already merged, but anyway:

Tested-by: Alice Mikityanska <alice.kernel@fastmail.im>

> The IPv6 prefix route of the tunnel address has metric 256, while
> "ip -6 route change" without a metric looks for a route with the default
> metric 1024, so nothing is changed. The test still passes, but without
> the larger initcwnd it is meant to use.
>
> Pass the metric of the prefix route.
>
> Fixes: 1d62b83fb751 ("selftests: net: Fix slow configurations in 
> big_tcp_tunnels.sh")
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/net/big_tcp_tunnels.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/big_tcp_tunnels.sh 
> b/tools/testing/selftests/net/big_tcp_tunnels.sh
> index cc0875e52fb9..fb43fed824e3 100755
> --- a/tools/testing/selftests/net/big_tcp_tunnels.sh
> +++ b/tools/testing/selftests/net/big_tcp_tunnels.sh
> @@ -145,7 +145,8 @@ do_test() {
>  			    route change 192.168.2.0/24 dev tun0 initcwnd 100
>  		else
>  			ip -netns "$CLIENT_NS" -6 \
> -			    route change 2001:db8::2:0/112 dev tun0 initcwnd 100
> +			    route change 2001:db8::2:0/112 dev tun0 initcwnd 100 \
> +			    metric 256
>  		fi
>  	else
>  		ip netns exec "$CLIENT_NS" \
> -- 
> 2.43.0
