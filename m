Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8153C3955E2
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571723; cv=none; b=Vhw0gFRI2fsRxnMocsuCoGTJ36llALwWfa16Q28POHpAp1na1aZfCQXYpQKXfEclHztWQ+BDVcYVlwUgfMz4vtVZsj4aUhvqgbw6fQFbOdI3269QVp4ZNQ7bmqVVe3+nMmVcE78Hg4J4GvgF8SrfSUEunMXukrJFnNGQVvOQ6Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571723; c=relaxed/simple;
	bh=s4jjt2BBHxaI2aAA5bwHo+SKjtGAz2YWOkmoQFSMOV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aU97PUQ9UncjmS8ZBoXvj2X4r8wDSsxZ1ymE5qKR8Ujc0/VLFd9VwStk1lr3cgEzJyIKlYFZhQQzcn6Qyy+EuA6Lo2mIHMzFpyhHRkCsAeDMXYbt8A4pADxL2g7nygOcY5ml2k/tbN/I+oulZbwYZLFZasNNZmHU19qkJMpbP94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJCUA0TM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJCUA0TM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791571720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLJL/mFUdKlXJidqQcf7VxgZvQrWlq/QP59klTXlG88=;
	b=FJCUA0TM89ccHQTuV08DBxfW1J0kFul3G41epZaVbGAsEdvNkn821xE/J+gObyBGhos2dw
	7UzDyj89EH0J4BTRXCh3ZDt2ZZphica8zBk03eyCFpESvBiVcHUier1VZniQbGCl8mWKmc
	SHgG6sQ8EBu05baGKkaoKs2b+NBD1h8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-nO6vJIOeNFeYaImqYpLOQA-1; Fri,
 9 Oct 2026 18:48:38 +0000
X-MC-Unique: nO6vJIOeNFeYaImqYpLOQA-1
X-Mimecast-MFC-AGG-ID: nO6vJIOeNFeYaImqYpLOQA_1791571717
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04F0F195E917;
	Fri,  9 Oct 2026 18:48:37 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 798D8472;
	Fri,  9 Oct 2026 18:48:34 +0000 (UTC)
Message-ID: <5f3ed318-db89-4c52-91b7-46b49e99f216@redhat.com>
Date: Fri, 9 Oct 2026 20:48:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/4] dpll: zl3073x: reject inexact frequencies for
 N-divided outputs
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20261006153116.347497-4-ivecera@redhat.com>
 <179147350412.434549.10496013315426964523@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179147350412.434549.10496013315426964523@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 10/8/26 17:31, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In the P-pin branch of zl3073x_dpll_output_pin_frequency_set()
>    (drivers/dpll/zl3073x/dpll.c:1016-1031), the patch widens the product…
> 
> Pre-existing issues:
> - [High] A privileged netlink request for frequency 0 can reach the
>    unchecked division `new_div = synth_freq / (u32)frequency;` in…
> - [Low] The four NL_SET_ERR_MSG_FMT() calls this patch adds to
>    zl3073x_dpll_output_pin_frequency_set() (drivers/dpll/zl3073x/dpll.c,…
> 
> --
> 
> dpll: zl3073x: reject inexact frequencies for N-divided outputs
> 
> This patch changes zl3073x_dpll_output_pin_frequency_set() to check the
> division remainder when it computes esync_n_period for N-divided outputs.
> A request is rejected if it does not divide evenly or if the N-pin
> frequency would not stay below the P-pin frequency. Both failure cases
> get new extack messages.
> 
>> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>> index 7c997966c3c33..65107b4cc4f82 100644
>> --- a/drivers/dpll/zl3073x/dpll.c
>> +++ b/drivers/dpll/zl3073x/dpll.c
>> @@ -1007,15 +1007,28 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
> 
> [Severity: High]
> This is a pre-existing issue, but can a frequency of 0 reach the division
> at the top of zl3073x_dpll_output_pin_frequency_set()?

Yes. In V4 I will add a separate patch that will stops offering a 0 Hz current
frequency as supported, so the DPLL core rejects a 0 Hz request before it
reaches the driver.

> 	new_div = synth_freq / (u32)frequency;
> 
> zl3073x_dev_output_pin_freq_get() uses integer division, so a sub-Hz
> output reads back as 0 Hz. For example, with a 600 MHz synth, an N-divided
> output, div=60 and esync_n_period=20000000, N is 0.5 Hz and is reported
> as 0. zl3073x_out_state_fetch() only rejects zero divisors.
> 
> zl3073x_pin_props_get() in drivers/dpll/zl3073x/prop.c then always
> registers the current frequency as supported. This bypasses the !freq
> check in zl3073x_pin_check_freq():
> 
> 	ranges[0] = (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_freq);
> 
> Suppose firmware also lists 1 Hz for that N-pin. A CAP_NET_ADMIN user can
> set the N-pin to 1 Hz and then request 0 Hz:
> 
> dpll_pin_freq_set()
>    dpll_pin_is_freq_supported(0)   -> true, ranges[0] is {0, 0}
>    freq != old_freq (1)
>    ops->frequency_set(..., 0, ...)
>      zl3073x_dpll_output_pin_frequency_set()
>        synth_freq / (u32)0
> 
> The division happens before any of the new remainder checks run.
> 
> There may be a similar path through a non N-divided output with
> div > synth_freq, where P reads as 0 Hz. The DPLL_A_PIN_FREQUENCY policy
> is a plain NLA_U64 with no range. This code is unchanged at the end of
> the series.
> 
> Would rejecting a zero frequency here, or in dpll_pin_freq_set(), make
> sense?
> 
>>   
>>   	if (zl3073x_dpll_is_p_pin(pin)) {
> 
> [ ... ]
> 
>> -		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
>> -		if (!out.esync_n_period)
>> +		u64 prod = mul_u32_u32(out.esync_n_period, out.div);
>> +		u32 rem;
>> +
>> +		out.esync_n_period = div_u64_rem(prod, new_div, &rem);
> 
> [Severity: Medium]
> Is the 64-bit quotient silently truncated when it is stored in the u32
> out.esync_n_period?

Right. Will fix this in v4 so the quotient will be kept in u64 and the request
is rejected if it does not fit into u32.
> mul_u32_u32() widens prod, but the result of div_u64_rem() is narrowed
> before the rem and < 2 checks run. Those checks never see the upper bits.
> 
> For example, take a 600 MHz synth with div=12 and
> esync_n_period=0x80000001 read from hardware (P=50 MHz, N about 0.023 Hz).
> Requesting P=100 MHz gives new_div=6:
> 
>      prod     = 0x80000001 * 12 = 0x60000000C
>      quotient = 0x60000000C / 6 = 0x100000002, rem = 0
>      (u32)    = 2
> 
> Both checks pass, and zl3073x_out_state_set() commits div=6 and
> esync_n_period=2. The N-pin then jumps from about 0.023 Hz to 50 MHz.
> The commit message says this patch prevents that kind of N-pin shift.
> 
> zl3073x_out_state_fetch() only rejects a zero esync_n_period, so it
> accepts this state from hardware. The driver's own N-pin path cannot
> create it, but EEPROM or firmware can.
> 
> Could the quotient be kept in a u64 temporary, with values above U32_MAX
> rejected before the assignment? This code is unchanged at the end of the
> series.
> 
>> +		if (rem != 0) {
>> +			NL_SET_ERR_MSG_FMT(extack,
>> +					   "OUT%uN freq must divide OUT%uP freq",
>> +					   out_id, out_id);
>>   			return -EINVAL;
>> +		}
> 
> [Severity: Low]
> This isn't a bug introduced by this patch, but do the new extack messages
> (here and in the N-pin branch) ever reach userspace?

No, dpll_pin_freq_set() overwrites them. That is a DPLL core issue and
out of scope for this series.

^^^
Jiri, Arek, Vadim? There are many places that simply overwrite extack messages
from a driver's callbacks.

> The only caller, dpll_pin_freq_set(), sets its own message whenever
> frequency_set() fails:
> 
> drivers/dpll/dpll_netlink.c:dpll_pin_freq_set() {
>      ...
> 	if (ret) {
> 		NL_SET_ERR_MSG_FMT(extack,
> 				   "frequency set failed for dpll_id:%u",
> 				   dpll->id);
> 		return ret;
> 	}
>      ...
> }
> 
> NL_SET_ERR_MSG_FMT() writes into the same extack->_msg_buf and points
> extack->_msg at it again. Userspace therefore gets only the generic
> message. The driver text shows up only in the netlink_extack tracepoint.
> The core still overwrites the message at the end of the series.
> 
> A smaller point: in the P-pin branch the remainder check runs before the
> < 2 check. If the requested P frequency is below the current N frequency
> (new_div > esync_n_period * div), the quotient is 0 and rem equals prod.
> That case gets "must divide" instead of "must be less than". Would
> checking esync_n_period < 2 first give the more accurate message?
Yes, will fix in v4.

Thanks,
Ivan

pw-bot: cr

