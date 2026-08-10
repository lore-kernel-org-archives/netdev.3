Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA97282F06
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389608; cv=none; b=i8HRbawnAB8237BuYFNWEsf8ECxPiWkqO94fEkkhBhyZ+QJHpN/h4e3RG5ILyKtCEO7+8H4OjmcgTlL0qClgcF6mYugMnbd9YAbMLL1uBBmvBa3KMNOqyXaV6og6oy2JKu1kVZVdrr9MV2KxfA5vIDqBdUlj679eaXTWJgWpY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389608; c=relaxed/simple;
	bh=c/eCHOhufICxSVfplyt7ia/1ajVFuIH73K/DMS7Y5/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAYkCNXtuWibpNRXUMjGAq2HWR4Jt9NAXxElOxO99EsrwwtplHhJw2+m5rrNYMNwfXPGIrjsbwHvqYUuCbj4+vfa2ENiXB/8AvrRtcS8ZvGCp0JEzA+r+3ISfykUCBNET8RjurltbRMvz/GhDep3h+MZYyQJKO6hsEe4RcXk1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y3sRTvlc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y3sRTvlc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2Bcx613741;
	Mon, 10 Aug 2026 19:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8Cb+8d
	MmwIox3uMtlSo4onwiFYTYDMBpjuIWuoL+n5M=; b=Y3sRTvlccxz1akT3VmhO9c
	FQX2EUf13huqt2YCGqg05QvxyPP0xaTHV/XE+6iy2ccg9T8xbaeivPSrmuY8wyMj
	c4z2sW4mhqjedhvQTDH0aXHseYX+t6FiIt6VE6Sz9Y0ITbJ6lfxndF2H4KVWnzVD
	ce7Rp6I51lwGGvbYF+VYgekKRinozjQHKmcyZC7gmGGhBiBGUZ28GR9bWovwILqo
	E3rc4lEGiQe4mVZ4r2XotIZ7YFfTTNSxKqjfxaDXXnxcysIdC5djDUQm5uam6ftk
	EMFrA6qSLM4K9QWYZJNioS0hM3Yi776r7A7I1rWUpoagq3WC+qyXz2mIrdV0GCDA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjysqd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:19:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJBrVd018110;
	Mon, 10 Aug 2026 19:19:51 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g5ypy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:19:51 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJJo4G49152372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:19:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25A805804B;
	Mon, 10 Aug 2026 19:19:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F27A058055;
	Mon, 10 Aug 2026 19:19:47 +0000 (GMT)
Received: from [9.67.152.96] (unknown [9.67.152.96])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:19:47 +0000 (GMT)
Message-ID: <3da6179f-c09a-4651-914e-c0b89bb0c466@linux.ibm.com>
Date: Mon, 10 Aug 2026 12:19:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 01/14] ibmveth: Add MQ RX hypercall wrappers
 and call definitions
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
        pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
        shaik.abdulla1@ibm.com, davemarq@linux.ibm.com
References: <1bb2ecd260f27171c534b9beda377b75ea1790ae.1785457143.git.mmc@linux.ibm.com>
 <20260806183614.3171785-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260806183614.3171785-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfXxmjY768grXbX
 DDkiGUJduFZ9EGK5yUbpDuVYLrwjuNnVnMiPh26iw46L++LBMcbQM6fdZtMNZlS8g4ZPSbKD34q
 B53w6dGp4Mlvd8Sz/wiS7rF+x+QHXWASxM2qiMhW5Ow3uy7ALCuKGs6WRfZBjyG7R2cRWG9q7em
 2XIaFLYeDI3sYv4HZaz4tZDoa6tAjMTwKcsXYKPguOlq5agvYuUCNq0bTfLHOKervBmzkY1Jrj8
 MH7t0UBhghoF3uKiZ2ENkptLHglysa+aSduayeAhSAOSJ2joLK9AM0vEM33dUgJo+XqiOUYd2E1
 ZcAqVmiZT+tk1Ffm2uOPGgVxe2LLEzFnGDSqU/K47A3VeKDpXhOoDRJb1mJ7zJYOng0/HfohDN1
 TuEWD7fq2jYEwNHZEzqi8FDPhWV8o/Rv+XZ6ukDvc+mXH2VbgsM/X/zFLSICKaJLF422PFiNuCc
 0rbbMt6eh04uQ5Wk9Ag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfXxrba2Y6IH0Ae
 EJUJeuGHN6AjRRv1AR8pnph9qUEVn0qpwL7415Dzuh4ScDODJSUULIZhxlyV7ZtBl1S0I5T0YGw
 GocnAwKpemL7E1B0XF2oPJNp593kzQo=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7a2459 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=SNiIGSxTkIxgdVmd4FEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6-vsZyGf-mzeE0F80rDcmh1hDhUimmmf
X-Proofpoint-ORIG-GUID: DFwYmzozXtDr6ATHJA2gz-X4yoZFXgLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100162

Hi Jakub,

Thanks for the review, and I appreciate the detailed review across the 
whole series.

More broadly, I agree with the overall direction of your review. For v5
I plan to fold the follow-up fixes back into the patches where they
belong and make the changelogs clearer, so the series reads more cleanly
end to end.

On 8/6/26 11:36 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Add MQ RX hypercall wrappers and call definitions
>
> This adds three new PHYP call IDs for multi-queue receive support and four
> static inline hcall wrapper helpers in ibmveth.h, bumping MAX_HCALL_OPCODE
> to the highest new opcode. No callers are added by this patch.
>
> A couple of questions below about the new wrappers and about the hvcall.h
> hunk.
>> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
>> index dff90a7d7f70b..d79baf2e38273 100644
>> --- a/arch/powerpc/include/asm/hvcall.h
>> +++ b/arch/powerpc/include/asm/hvcall.h
>> @@ -362,7 +362,10 @@
>>   #define H_GUEST_DELETE		0x488
>>   #define H_PKS_WRAP_OBJECT	0x490
>>   #define H_PKS_UNWRAP_OBJECT	0x494
>> -#define MAX_HCALL_OPCODE	H_PKS_UNWRAP_OBJECT
>> +#define H_REG_LOGICAL_LAN_QUEUE 0x49C
>> +#define H_ADD_LOGICAL_LAN_BUFFERS_QUEUE 0x4A0
>> +#define H_FREE_LOGICAL_LAN_QUEUE 0x4A8
>> +#define MAX_HCALL_OPCODE	H_FREE_LOGICAL_LAN_QUEUE
> [Severity: Low]
> Could the changelog cite the PAPR/PHYP document and revision that assigns
> 0x49C, 0x4A0 and 0x4A8?  These become architecture-wide constants shared
> with the KVM hcall emulation, so it would help to have the provenance
> recorded in the commit.
Agreed. The first PAPR revision that contains the MQ hcalls is
PAPR 11.20.00, and in v5 I will cite that revision explicitly in the
patch-1 changelog.
> There are also holes left at 0x498 and at 0x4A4 (the latter from dropping
> H_FREE_LOGICAL_LAN_BUFFER_QUEUE in v4).  Are those numbers reserved by the
> architecture for something else, or are they simply unused?

For the gaps, `0x4A4` remains reserved for
`H_FREE_LOGICAL_LAN_BUFFER_QUEUE`, and `0x498` is reserved. This series
does not need `H_FREE_LOGICAL_LAN_BUFFER_QUEUE` for the normal queue
teardown path, so I am not adding it here.

>
> Separately, MAX_HCALL_OPCODE is not driver-local.  It sizes
> kvm_arch.enabled_hcalls:
>
>    arch/powerpc/include/asm/kvm_host.h:
>        DECLARE_BITMAP(enabled_hcalls, MAX_HCALL_OPCODE/4 + 1);
>
> and it bounds the userspace-visible opcode range accepted by
> KVM_CAP_PPC_ENABLE_HCALL:
>
>    arch/powerpc/kvm/powerpc.c:kvm_vm_ioctl_enable_cap() {
>        ...
>        if (hcall > MAX_HCALL_OPCODE || (hcall & 3) ||
>            cap->args[1] > 1)
>        ...
>    }
>
> It also sizes the per-CPU hcall statistics array in
> arch/powerpc/platforms/pseries/hvCall_inst.c and gates
> kvmppc_pseries_do_hcall() and kvmppc_h_pr().  As far as I can tell the bump
> is behaviourally inert for these new opcodes, since kvm_vm_ioctl_enable_cap()
> still rejects them via kvmppc_book3s_hcall_implemented(), and the KVM
> dispatch path ends up returning RESUME_HOST either way.  Would it be worth
> mentioning the cross-subsystem effect in the changelog so the powerpc/KVM
> side has something to ack against?
Sure, for `MAX_HCALL_OPCODE`, I agree that the bump has a 
cross-subsystem effect
because it sizes KVM's enabled-hcall bitmap and bounds
`KVM_CAP_PPC_ENABLE_HCALL`. In v5 I will call that out explicitly in the
patch-1 changelog rather than leaving it implicit.

>>   
>>   /* Scope args for H_SCM_UNBIND_ALL */
>>   #define H_UNBIND_SCOPE_ALL (0x1)
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
>> index d87713668ed30..c88dbeb7cd967 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.h
>> +++ b/drivers/net/ethernet/ibm/ibmveth.h
>> @@ -66,6 +66,143 @@ static inline long h_add_logical_lan_buffers(unsigned long unit_address,
>>   			    desc5, desc6, desc7, desc8);
>>   }
>>   
>> +/**
>> + * h_reg_logical_lan_queue - Register a subordinate receive queue
> [Severity: Low]
> This isn't a bug, but the naming here diverges from the existing wrappers in
> this file, which all spell it out as h_register_logical_lan() and
> h_free_logical_lan().  Would h_register_logical_lan_queue() read more
> consistently?
>
> [ ... ]
Agreed. In v5 I will rename it to `h_register_logical_lan_queue()` so it
matches the existing wrapper naming.

>> +static inline long h_reg_logical_lan_queue(unsigned long unit_address,
>> +					   unsigned long buffer_list,
>> +					   unsigned long rec_queue,
>> +					   unsigned long *queue_handle,
>> +					   unsigned long *irq)
>                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> [Severity: Low]
> This helper returns the queue handle as unsigned long *, which matches
> retbuf's element type and matches the other output parameters in this header
> (h_send_logical_lan()'s corellator_out, h_illan_attributes()'s
> ret_attributes).
>
> But h_register_logical_lan_with_handle() below declares the same conceptual
> value, the PHYP queue handle read out of retbuf[0], as u64 *.  Can these two
> be made to agree?  As it stands, callers have to pick a different storage
> type depending on which of the two helpers they call, even though both are
> returning the same thing.
>
> The commit message says the new wrappers have "argument ordering and return
> semantics matching the existing ibmveth hcall wrappers", which holds for
> this one but not for the u64 * variant.
>
> [ ... ]
Agreed. In v5 both `h_register_logical_lan_queue()` and
`h_register_logical_lan_with_handle()` will use `unsigned long
*queue_handle`, matching the sibling wrappers and avoiding different
caller-side storage depending on which helper is used.

>> +static inline long h_free_logical_lan_queue(unsigned long unit_address,
>> +					    unsigned long queue_handle)
>> +{
>> +	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
>> +
>> +	return plpar_hcall9(H_FREE_LOGICAL_LAN_QUEUE,
>> +			    retbuf, unit_address, queue_handle);
>> +}
> [Severity: Low]
> The kerneldoc above documents no output data for this hcall, and retbuf is
> never read.  Why not use plpar_hcall_norets() here, the way the existing
> counterpart in this file does?
>
>    #define h_free_logical_lan(ua) \
>      plpar_hcall_norets(H_FREE_LOGICAL_LAN, ua)
>
> That would drop the dead nine-entry stack buffer.
>
> [ ... ]
Agreed. In v5 I will switch `h_free_logical_lan_queue()` to
`plpar_hcall_norets()` and drop the unused return buffer.

>> +static inline long
>> +h_register_logical_lan_with_handle(unsigned long unit_address,
>> +				   unsigned long buffer_list,
>> +				   unsigned long rec_queue,
>> +				   unsigned long filter_list,
>> +				   unsigned long mac_address,
>> +				   u64 *queue_handle)
>                                      ^^^^^^^^^^^^^^^^^^
>
> [Severity: Low]
> This is the u64 * side of the inconsistency noted above.  Both types are
> 64-bit on ppc64, which is the only configuration that builds ibmveth, and
> the callers added later in the series do compile against both prototypes, so
> this looks like a readability issue rather than a functional one.  Could both
> helpers use unsigned long * for the handle?

|In v5 both helpers will use unsigned long *queue_handle.|

Thanks again for the detailed review,
Mingming

