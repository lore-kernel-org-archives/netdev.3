Received: from b2412.mx.srv.dfn.de (b2412.mx.srv.dfn.de [194.95.235.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4F1346FC3
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.95.235.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280229; cv=none; b=RNQOtF0I1a7Hffn5qrFxltBLOyu7uEuix4IkFbUPY0SBk1/b6MsIcIG0809w4W5giASt3B3z4hJOl5G81pfjlN4Iz1nUWkNTf8ESU8WAhVveDMBhvdPBa52/+/VuTpThuDnCbyquIRFE/wkCUH43wT/UasOnnd3E4nYeE9K06ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280229; c=relaxed/simple;
	bh=IL1AdIU/mp8X2QK26dKJwpwZLQo9Rs6fq5FpfopqTrU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EOa+2cBFGx7fNb0dx/TP1dwCB0eTzO/WKWXDjynEII21xEqV0FiQDpb24Q2YHYrOwh8HW1T8T5JKWKp55RsbxgIzBiO2Lv9hdCffS7CyyPNuGCDQK987S33WYp7NwK2Q2aaCSBysN7xfipLszbcxBe/OCGCEuzn7mL6iCn3NKhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-osnabrueck.de; spf=pass smtp.mailfrom=uni-osnabrueck.de; arc=none smtp.client-ip=194.95.235.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-osnabrueck.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uni-osnabrueck.de
Received: from vm411.rz.uni-osnabrueck.de (smtp-auth-1.serv.uni-osnabrueck.de [131.173.16.143])
	by b2412.mx.srv.dfn.de (Postfix) with ESMTPS id 2049D1C016A;
	Thu,  5 Feb 2026 09:30:19 +0100 (CET)
Received: from [IPV6:2001:638:508:f000:869d:11bb:5529:ad4a] (unknown [IPv6:2001:638:508:f000:869d:11bb:5529:ad4a])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: kelmenhorst)
	by vm411.rz.uni-osnabrueck.de (Postfix) with ESMTPSA id D525930056C3;
	Thu,  5 Feb 2026 09:30:18 +0100 (CET)
Message-ID: <e0e3738e-c01f-4c2e-a782-3e7c99d8b647@uni-osnabrueck.de>
Date: Thu, 5 Feb 2026 09:29:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kathrin Elmenhorst <kelmenhorst@uni-osnabrueck.de>
Subject: Re: [PATCH net-next] net: tcp_bbr: use high pacing gain when the
 sender fails to put enough data inflight
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org
References: <20260202101454.89445-1-kelmenhorst@uni-osnabrueck.de>
 <CADVnQykLpW+GV6sSG5py1J+WTZFM-=JObhYS7Pwd=9ut1GY1BQ@mail.gmail.com>
 <f1137fcf-1778-4811-9211-4beb95db3a32@uni-osnabrueck.de>
 <CADVnQy=u4zQjC6A9WBvnZOvRFAVzi=0rSzbSs_4kujB2u0U2EQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADVnQy=u4zQjC6A9WBvnZOvRFAVzi=0rSzbSs_4kujB2u0U2EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/3/26 15:29, Neal Cardwell wrote:

> The "or is reset to" part is an incorrect reading of the code; BBR
> does not reset itself to STARTUP when the connection is app-limited.
> :-)
> Please note that in bbr_cwnd_event() when an app-limited connection in
> BBR_PROBE_BW restarts from idle, BBR sets the pacing rate to 1.0x the
> estimated bandwidth. This is the common case for long-lived BBR
> connections with application-limited behavior. Your proposed patch
> makes the behavior much more aggressive in this case.

Got you, so the high pacing gain for app-limited sockets only applies
at the start, before BBR thinks that the full bandwidth has been
reached for the first time.

> Related questions would be: for VMs using paced CUBIC (CUBIC with fq
> qdisc): (a) how much does paced CUBIC suffer on  low-CPU-budget VMs?
> (b) how much does this alternate len_ns computation help paced CUBIC
> on such VMs?
Regarding (a), we did not test this as thoroughly as BBR, but we saw
that paced CUBIC can have similar issues under CPU contention, but the
effect was smaller than with BBR, especially for shorter off-CPU
times. As in, CUBIC+fq only starts slowing down under more severe CPU
contention conditions, especially when off-CPU times surpass the RTT.
I suspect this is because the performance degradation not only depends
on the rate limit given by the pacing and the available CPU-time per
RTT but also on the reaction of the CCA to less-than-expected delivery
rates and added delay - CUBIC is less sensitive regarding the latter.
In any case, I think it's a good idea to solve this problem for paced
TCP generally, not just for BBR.

> I suspect we want something that builds  on the following patches by Eric:
Thanks! I will check out the patches and test them with CUBIC and fq
on our setup.


Thank you for the feedback!
Kathrin

