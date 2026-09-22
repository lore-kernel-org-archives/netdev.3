Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73E55C1C9
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091264; cv=none; b=jHPb+MgKNAr5olFz4BUTDSfvcgnyKU74DyqDnj0mNF2oFt1nSEYjJXh1TE+vbExoe6yRn6Ykq9Ojwh8PBo1emZ31EW0p5kRPI53gNOR/xvKquNjv+uQ+ZL4S92N1BWSpiYCFodzD7OEItFc2o97YQ668uxJofE9eiRtgyLXt3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091264; c=relaxed/simple;
	bh=EJDiYeiJhHLqMS4QEKjrDDO5ntp031Qoz8AN4F9L8IY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S0vHRp4Vbt3CesNiTEQWoiNxoDLaCRXZ5iOhUzRkF7jGKYZAMuYwZg5yntWsq+ZBQZPIFNgb/tJ9Y7Gc+QXvwqtPC9k2AoYnjJ47Chx/Ew/nOyHwntm2OvZPUUAX7JOsFjXJd3ZKj6eu2FdiubNEBhUgJ5A/4IYflyRp82DKMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tr/8VGAX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3Y7QpCa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tr/8VGAX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3Y7QpCa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790091261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tfNl2I4x4/cNHRA9ep8x0OYkNfYTKx3divzOhknoMxE=;
	b=Tr/8VGAXL5srt9wD9SW4FbktALjJKZB6icnh6tEzYC5uEr2+/MwMfaW6X0WQJOTobZk1vu
	j7jj3FSNIexMi3kBbcWxRXKAlyMsKdiysq+FOyL6hX8kz/t8e1xsXxM+BoxXhaR5RP33IL
	lnsPSEjYEd3P4GwxTjD508HUyazcmW8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-OP2jHxBsPye3a0wt5PyIfg-1; Tue, 22 Sep 2026 11:34:19 -0400
X-MC-Unique: OP2jHxBsPye3a0wt5PyIfg-1
X-Mimecast-MFC-AGG-ID: OP2jHxBsPye3a0wt5PyIfg_1790091258
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e661c6440so23884285e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790091258; x=1790696058; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tfNl2I4x4/cNHRA9ep8x0OYkNfYTKx3divzOhknoMxE=;
        b=B3Y7QpCaxE1B8dQGISb0d5CAJ4WXA9msrh6YLjRJslTWt0vup6VshfYBUzap+OyNvi
         fzZ8wmxfomT6BKdZGb+R9WZl49x9RvOHHNFQk5clpz9Eh9nPISPYPq0e/nK5XXxpz0df
         Sq32C5yo6XI4ExMvurpkqB/tjj7ZDyCeiRTovx7PL1+n1zVRdADl2xg/pbcxIWY2OiMK
         yE+oPTdcHtyshl02Ht9AF1msLzzp73OF0jilnAtmBQxq021MZzaXb/9Xyq6OeMkHceWF
         A0lnEJ3VVb/7ys8DfAnyu3pF78QLcR44scsEU+3PPDRO8Ar/OzQE6P8PXPaLr1841Rwg
         KUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790091258; x=1790696058;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tfNl2I4x4/cNHRA9ep8x0OYkNfYTKx3divzOhknoMxE=;
        b=PY1w7eraxn+p4+dcpyMvtF2ba3D+6/zh4o/I9fTIbwf4qYpH/ZNGW0bFH5/KqB6AIn
         kU8TIrZ/OSrSEvrVRciNWfyTfG6O9vnEzvaUtvJEIlOQUTEVtS4W3zWFCYbIP6FBKA/8
         MVoG2DSdGZJ2+OXqsaB077ZDACHqeu4SpuiZ/W8NfxsPJmhrtj3gfNxBv5je7IDU+Is8
         8bIzP7pDMBeBpuQ43nmiNiWBFEIZm3MqUoAc9nPIi+rE8MAaihJpell161pR7jWFKe9G
         90XeTSiLwNVxFe/FNFMGI4dnsC8tgaps12vF4i67Wg+AlD+WAkdnYye4myxoV3sv3t/j
         YznQ==
X-Forwarded-Encrypted: i=1; AKwUvBxs9dCR/VokBxzKmZaRWLO1IgB9ZFVQH9Jrwd6lwxcF8CyZbH/uKcL/cppwAXg4U2gqnYdlaC4=@vger.kernel.org
X-Gm-Message-State: AFuF++n/401en1i3cCFKVEfawB9c8qa8HrAwD5UKUAJeytk6T6ssV+35
	8KzkneJN6ccESY5L0ouGwXw7XqmiLUyFQbSy+KNYVjDesfIJMeJSa1VEugrTenewxEMpgkvyUjz
	3YftVctaiiehBJBX0u6Ywpz0/E23lhAVmRyip/mwzrySK3Yb2riUIFkc5Bg==
X-Gm-Gg: AYBFou2l3UlU3z405xCgIXUdm0HSiJqzg+edX+cx7zgoLWosc3i6vyD9lXFTmYGOTga
	66bIdf/PyxT0o0qqVq4zcJbK75+JUH71suNYMeNd0Go9le54P/1oOYZ/O5CnxTtM3SdOr5tbWxg
	n4ieIJLEJ/+ydddGwd3UZfbPj8Q7yfbcBh8SysNwZadfNQs3Rbhg/dvwegu/lmhbpupn/BWGOdW
	LKjDSqHY093NONlcyN1KfMvClIuNNQ6zKTizXlI01Xkphg94ALp5uUoN0Rx5l2iPJeJ4cIaPglB
	eetErSfgfRT+MTXZ+PufpFVU7DFQJs2vVe7wphwfNcYbjRncwHJqBjxfP0fzbByqIYz2Fas2Rup
	RVu6kGInRwsi7fspkFgi1jaDnev7S
X-Received: by 2002:a05:6000:2012:b0:488:640e:f6ca with SMTP id ffacd0b85a97d-488640ef84bmr2884966f8f.55.1790091258423;
        Tue, 22 Sep 2026 08:34:18 -0700 (PDT)
X-Received: by 2002:a05:6000:2012:b0:488:640e:f6ca with SMTP id ffacd0b85a97d-488640ef84bmr2884921f8f.55.1790091258077;
        Tue, 22 Sep 2026 08:34:18 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488626d29dasm6266794f8f.0.2026.09.22.08.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:34:17 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,  Matthieu Baerts
 <matttbe@kernel.org>,  Steven Rostedt <rostedt@goodmis.org>,  Masami
 Hiramatsu <mhiramat@kernel.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Eelco Chaudron <echaudro@redhat.com>,
  dev@openvswitch.org,  linux-trace-kernel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,  Adrian Moreno
 <amorenoz@redhat.com>,  Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
In-Reply-To: <dca799b4-23f5-4b6f-be73-bad5a3d88007@ovn.org> (Ilya Maximets's
	message of "Tue, 22 Sep 2026 11:01:10 +0200")
References: <20260921101538.97286-6-johannes@sipsolutions.net>
	<20260921101538.97286-9-johannes@sipsolutions.net>
	<98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
	<7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org>
	<99e5f7c0d7debc8a59bac96e93f09600bf488ca8.camel@sipsolutions.net>
	<4a0240a7b9ff87302620a95c73f4f265cd428618.camel@sipsolutions.net>
	<dca799b4-23f5-4b6f-be73-bad5a3d88007@ovn.org>
Date: Tue, 22 Sep 2026 11:34:14 -0400
Message-ID: <f7tzex99u6h.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ilya Maximets <i.maximets@ovn.org> writes:

> On 9/22/26 1:20 AM, Johannes Berg wrote:
>> On Tue, 2026-09-22 at 00:36 +0200, Johannes Berg wrote:
>>>
>>> Indeed. Something like this (untested right now, didn't manage to spin
>>> up a test yet):
>>>
>>> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>>> index a31f7fb6882d..9b8edfcd2d1a 100755
>>> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>>> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>>> @@ -234,7 +234,7 @@ ovs_drop_reason_count()
>>>  	local reason=$1
>>>  
>>>  	local perf_output=`perf script -i ${ovs_dir}/perf.data -F trace:event,trace`
>>> -	local pattern="skb:kfree_skb:.*reason: $reason"
>>> +	local pattern="skb:kfree_skb:.*reason: $reason$"
>>>  
>>>  	return `echo "$perf_output" | grep "$pattern" | wc -l`
>>>  }
>>> @@ -790,15 +790,6 @@ test_psample() {
>>>  # - drop packets and verify the right drop reason is reported
>>>  test_drop_reason() {
>>>  	which perf >/dev/null 2>&1 || return $ksft_skip
>>> -	which pahole >/dev/null 2>&1 || return $ksft_skip
>>> -
>>> -	ovs_drop_subsys=$(pahole -C skb_drop_reason_subsys |
>>> -			      awk '/OPENVSWITCH/ { print $3; }' |
>>> -			      tr -d ,)
>>> -	if [ -z "$ovs_drop_subsys" ]; then
>>> -		info "failed to get OVS drop subsys ID"
>>> -		return $ksft_skip
>>> -	fi
>>>  
>>>  	sbx_add "test_drop_reason" || return $?
>>>  
>>> @@ -842,7 +833,7 @@ test_drop_reason() {
>>>  		"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" 'drop'
>>>  
>>>  	ovs_drop_record_and_run "test_drop_reason" ip netns exec client ping -c 2 172.31.110.20
>>> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0001 # OVS_DROP_FLOW_ACTION
>>> +	ovs_drop_reason_count OVS_DROP_LAST_ACTION
>>>  	if [[ "$?" -ne "2" ]]; then
>>>  		info "Did not detect expected drops: $?"
>>>  		return 1
>>> @@ -859,7 +850,7 @@ test_drop_reason() {
>>>  
>>>  	ovs_drop_record_and_run \
>>>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 6000
>>> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0004 # OVS_DROP_EXPLICIT_ACTION_ERROR
>>> +	ovs_drop_reason_count OVS_DROP_EXPLICIT_WITH_ERROR
>>>  	if [[ "$?" -ne "1" ]]; then
>>>  		info "Did not detect expected explicit error drops: $?"
>>>  		return 1
>>> @@ -867,7 +858,7 @@ test_drop_reason() {
>>>  
>>>  	ovs_drop_record_and_run \
>>>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 7000
>>> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0003 # OVS_DROP_EXPLICIT_ACTION
>>> +	ovs_drop_reason_count OVS_DROP_EXPLICIT
>>>  	if [[ "$?" -ne "1" ]]; then
>>>  		info "Did not detect expected explicit drops: $?"
>>>  		return 1
>>>
>> 
>> No longer untested, that works.
>
> Looks nicer than parsing obscure numbers indeed!

+1 !

> Matthieu mentioned we'll need CONFIG_TRACEPOINTS in the selftest config
> shard: tools/testing/selftests/net/openvswitch/config
>
> Is that a new dependency or was it always there we just missed adding it
> to the config before?  (it's included in the common net config, so that
> is probably the reason why CI doesn't fail)

Yes, we missed it the first time around.

> Best regards, Ilya Maximets.

