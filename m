Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4FD40963B
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572461; cv=none; b=eRLkgQ29zIaIgVCFLjlptAVzgz6G2SGq3z0psiDuxf9veastxf1RENVnOeM9g9h0ju62bM6okoWpx2CdRw2Janxf4WOIZ/3898OPOyGMSurUoiQ4AL0vDQ+W8cbCObSCUniwNSn48r2BdpWF/Uq/bHr7tPOLDCTtcLs6YAaWTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572461; c=relaxed/simple;
	bh=/lFZRcmNSW3lZw1v83n87Avac7pc4Kp3gbkQWxUi+nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZT4dInXlKby8IiPdJNCfKjfJjN815xBA0Oo2DF3aDefa4apjzrQc+izMQsPwSwNCo+JjbJVq7XnfDXO+8oVCo80WM2cZrBDKew07wbrpsdZ0gUcO6zqaYRXi1N3vKhGRNdY6WF01NpsFmcO879XvSE4qQHLWYucLBZi0IbZ7Lu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OrbJdfZm; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OrbJdfZm"
Message-ID: <66925275-1d07-4a74-996a-ec14456999f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780572447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWCOT+3WwXwE95YAG0b/l/NlokI59TxeEDWAYxdMIiY=;
	b=OrbJdfZmGjeb/aBbf2B+uMBQ9Cwhu0PBU3IHjUqwharUxSR8JVP+SEJokaw7ERBD4/OZDX
	tBfqEaDjwN20je32VOQvTOVuLQMneqm+Ui8P0yn/HL+VO5NndUpuh3XjfILUec4qWddWmO
	2a+3nrvXmpvrlneEv2wuY+omfBFPuLg=
Date: Thu, 4 Jun 2026 19:27:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC net] tls: TLS_SW sendfile() stalls at large MSS
To: "WindowsForum.com" <admin@windowsforum.com>
Cc: netdev@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20260603171922.4A1512AA9D4@windowsforum.com>
 <345af51b-9135-4ca0-816b-781a61fdbcbe@linux.dev>
 <CAP_6uV+1zQqLtwH30SyuQmyHc03uv9ea+ZUr42TGSCozU4KcdA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAP_6uV+1zQqLtwH30SyuQmyHc03uv9ea+ZUr42TGSCozU4KcdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/4/26 2:53 PM, WindowsForum.com wrote:
> Thanks for testing. The non-reproduction is maybe now the key data 
> point. My reproducer omitted a precondition my hosts happened to meet: 
> a low net.ipv4.tcp_notsent_lowat. To reproduce, add before running:
>
> sysctl -w net.ipv4.tcp_notsent_lowat=16384


I see.

>
> Root cause
> ----------
> The stalling hosts have tcp_notsent_lowat=16384 (local web tuning); 
> the stock default is effectively disabled. A TLS 1.3 record is 16406 
> bytes (TLS_MAX_PAYLOAD_SIZE 16384 + 22), just above that watermark -- 
> so once tls_sw queues a single completed record, notsent (16406) 
> exceeds the lowat, tcp_stream_memory_free() returns false, and tls_sw 
> parks in sk_stream_wait_memory() holding exactly one corked record 
> (the notsent:16406 + persist state from the original dump). With the 
> default lowat, tls_sw keeps queuing, the MSG_MORE cork flushes at each 
> sendfile() boundary, packets_out stays non-zero, and the persist timer 
> never arms -- which is why stock kernels don't show it.
>
> Three conditions must coincide:
>   (a) MSG_MORE forwarded on a completed record -> the sub-MSS record 
> is corked [the bug];
>   (b) tcp_notsent_lowat < one TLS record (16406) -> tls_sw blocks 
> after that one record instead of streaming past it [the trigger I'd 
> omitted];
>   (c) large MSS -> the record is sub-MSS, so the cork engages [the 
> amplifier].
>
> Confirmed by flipping only that knob: on a stalling host, restoring 
> the default lowat -> 2.89 GiB/s; on a healthy host, setting 
> lowat=16384 -> stalls (~0.0001 GiB/s). Everything that merely 
> correlated (kernel build, congestion control/qdisc, wmem/rmem, 
> tcp_mem, tcp_limit_output_bytes, CPU count, AES-GCM impl) was 
> flip-tested and ruled out.
>
> This doesn't change the proposed fix: clearing MSG_MORE for a full 
> record sends it immediately, so the deadlock can't form regardless of 
> tcp_notsent_lowat.


IMO, force-clearing the MSG_MORE flag for each record is not a good idea,

since we want multiple "APPLICATION DATA" frames in one TCP payload.

>
> If you had not submitted your reply I don't think I would have kept 
> testing it - hope this information is useful to the group.
>
>
Maybe we can skip the sk_stream_memory_free check if MSG_MORE is 
present. The lower tcp_sendmsg_locked will check it again.



