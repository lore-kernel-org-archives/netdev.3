Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE14F053C;
	Wed, 16 Sep 2026 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564042; cv=none; b=l/OoNgddo0ld5l8Y5LauTN87y+9f4MMpWUB0bOXELhk0MFyQzRHJEQAlwvddOCg5iH+/yU9j4YPEkZNtXy0kGxtiylpIdo34Rzo8/+0pB8INRkoG4Xi3+9Knh7vfHSBrA2531nYzx4bJJlV4J8fabT1etUXl+A+3HVDsd7p4jdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564042; c=relaxed/simple;
	bh=zBJc7dbRHBNYBD4D+tQSab8ogsTVlAfEML/+Ul9fzE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxikU8PRygZTrf20Vn6bKa8zFCCenscdKWYsRfgmPX4HjEHVOzJtZ2++AMoF2FDrEHiXXe84tgek0bsksv3n+QvX9e0YOH6myLFcjgmfuSOxrhDNFdD/9YTjPyNpYHjVjwPKSQtBOd4m8gXuTA7JNsSkIQ63tOfDHT4SlfE+z0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=mgUjUVED; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="mgUjUVED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=KtSHIOcqGzDsGXMBO+gjFL4XAMuEjPH5tm95W3n6k6k=;
	b=mgUjUVEDrIaP4OWzIYbjBx4vEOctZ4UrhdBTy7CEK8elNJZssho25LJ/8g0oC2
	T4NSIBYDxwAMvIMm3qDCrXxqm+dz3EyheFr68NDQQwpbwbA8T0ByGXM+Jto7lcc2
	q8Ha9xbPl+9zQzRyhX0PdAbrlFMeB9QWZzizUdS4JTB1Q=
Message-ID: <3ab21824-7863-4fb5-9e13-cf0dfd1aa4df@126.com>
Date: Wed, 16 Sep 2026 21:06:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: limit the DDP profile count
 returned by the firmware
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20260915120354.610499-1-xiaolinkui@126.com>
 <IA3PR11MB898605544C71BB998C0FA35DE5B92@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <IA3PR11MB898605544C71BB998C0FA35DE5B92@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PikvCgAHFus_lKpqwxjiHw--.21203S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw17Cr1fKFWfKw4DtF1UWrg_yoWrKFWxpa
	y5Ga1UGFn5JF1jgw1Uta17CFy09a4IyryYgayagas8Xrn8tFs5WryDKrWF9FnFvrWkGr15
	tF4v9r92yF4qqrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uuv38UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqAF6UWqqlEGHzwAA3f



On 2026/9/16 14:03, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Linkui Xiao <xiaolinkui@126.com>
>> Sent: Tuesday, September 15, 2026 2:04 PM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com
>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>
>> Subject: [Intel-wired-lan] [PATCH net] i40e: limit the DDP profile
>> count returned by the firmware
>>
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> i40e_aq_get_ddp_list() writes into a I40E_PROFILE_LIST_SIZE buffer,
>> which is sized for I40E_MAX_PROFILE_NUM (16) i40e_profile_info entries
>> plus the 4 byte p_count header. i40e_ddp_does_profile_exist() and
>> i40e_ddp_does_profile_overlap() then loop over profile_list->p_count
>> without bounding it, so a firmware reporting more than 16 profiles
>> makes both helpers walk past the end of the on-stack buff[] and
>> compare against whatever happens to follow it on the stack.
>>
>> Clamp the count to the number of entries the buffer can actually hold
>> and make the loop counter unsigned to match the field type.
>>
>> Fixes: cdc594e00370 ("i40e: Implement DDP support in i40e driver")
>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_ddp.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
>> b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
>> index daa9f2c42f70..1d6d8b3835a3 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
>> @@ -55,7 +55,7 @@ static int i40e_ddp_does_profile_exist(struct
>> i40e_hw *hw,
>>   	struct i40e_ddp_profile_list *profile_list;
>>   	u8 buff[I40E_PROFILE_LIST_SIZE];
>>   	int status;
>> -	int i;
>> +	u32 i, p_count;
> RCT please
> 
>>
>>   	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE,
>> 0,
>>   				      NULL);
>> @@ -63,7 +63,12 @@ static int i40e_ddp_does_profile_exist(struct
>> i40e_hw *hw,
>>   		return -1;
>>
>>   	profile_list = (struct i40e_ddp_profile_list *)buff;
>> -	for (i = 0; i < profile_list->p_count; i++) {
>> +	/* Never walk past the end of buff[], the profile count
>> reported by
>> +	 * the firmware is not guaranteed to fit into the buffer we
>> gave it.
>> +	 */
>> +	p_count = min_t(u32, profile_list->p_count,
>> I40E_MAX_PROFILE_NUM);
>> +
>> +	for (i = 0; i < p_count; i++) {
>>   		if (i40e_ddp_profiles_eq(pinfo, &profile_list-
>>> p_info[i]))
>>   			return 1;
>>   	}
>> @@ -110,7 +115,7 @@ static int i40e_ddp_does_profile_overlap(struct
>> i40e_hw *hw,
>>   	struct i40e_ddp_profile_list *profile_list;
>>   	u8 buff[I40E_PROFILE_LIST_SIZE];
>>   	int status;
>> -	int i;
>> +	u32 i, p_count;
> RCT please
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Hi,

Thanks for the review and for the Reviewed-by tag.

Just to make sure I understand the "RCT please" comments correctly: are 
they referring to the Reverse Christmas Tree (RCT) variable declaration 
ordering convention, i.e. the local variables should be declared in 
decreasing order of line length? In both functions I currently have:
         struct i40e_ddp_profile_list *profile_list;
         u8 buff[I40E_PROFILE_LIST_SIZE];
         int status;
         u32 i, p_count;

If I understand RCT correctly, the expected order would be something like:
         struct i40e_ddp_profile_list *profile_list;
         u8 buff[I40E_PROFILE_LIST_SIZE];
         u32 i, p_count;
         int status;

Could you please confirm whether that is what is being asked for, and 
whether there are any other RCT-related issues in this patch?
Also, should I send a v2 with the RCT ordering fixed, or would you 
prefer to keep the current version as-is since the change is purely 
stylistic? I am happy to send a v2 if that is preferred.

Thanks,
Linkui
> 
>>
>>   	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE,
>> 0,
>>   				      NULL);
>> @@ -118,7 +123,12 @@ static int i40e_ddp_does_profile_overlap(struct
>> i40e_hw *hw,
>>   		return -EIO;
>>
>>   	profile_list = (struct i40e_ddp_profile_list *)buff;
>> -	for (i = 0; i < profile_list->p_count; i++) {
>> +	/* Never walk past the end of buff[], the profile count
>> reported by
>> +	 * the firmware is not guaranteed to fit into the buffer we
>> gave it.
>> +	 */
>> +	p_count = min_t(u32, profile_list->p_count,
>> I40E_MAX_PROFILE_NUM);
>> +
>> +	for (i = 0; i < p_count; i++) {
>>   		if (i40e_ddp_profiles_overlap(pinfo,
>>   					      &profile_list->p_info[i]))
>>   			return 1;
>> --
>> 2.25.1
> 

