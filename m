Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AEE568FA1
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062291; cv=none; b=f0BvGbHs0IDh+TAawdKI/3n9zdUCF3/8v0CMuDOyhVh3rTHP/txVe3/u1g+oHBzkKpwIpQVw3El1RYg+u1QwgjX3G707bnRqSssgtajppcCVZvoaee/Fyl5xJI8YBjwc8UUaz/fVfvrj59EiFEvbDhN4DIGnWB6jMMSi7HJjLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062291; c=relaxed/simple;
	bh=hOwAM19ellXTuSTfVu3GiJAsTHtYyEpB1hz91S9UrOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BlcERP6KyhHlyXUlxEC73bRANlmZ/Ef9CB5LYCQS5DDK84vV0PeOi1Twxh/+qGPip4sZyNnxTulYffUhhbvZAsB2SFhEjGH9o7W/jQpmkQ84SUqqxFRumERa1mI+QM8JlHnaddImnau1Qsl4M8onlrrCGyghOYyrx5WWjkI6UWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4+dGp39; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KG85I3IZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4+dGp39";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KG85I3IZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789062281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JT+A7W1MmDpVr6cMOdIJpFjVZmY1bGOG8YUIXDNF/Yo=;
	b=G4+dGp39oWxRAvZopn5TpcHx1W06U15uUSfD2BSpjHSI7f37sUldNxbaISPRXjMFxf2Bgr
	XYAIBvn9hhwFr8+US1J1SpdNmOPqxWWhf59NoFw0kHbwS/MynG32ihBeopUUFPej260lcT
	ufJI1bl23a0v85sW5Nqk9P8IXaBQWuA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-E4xdXTKlO3ueh4QPMrTIjw-1; Thu, 10 Sep 2026 13:44:38 -0400
X-MC-Unique: E4xdXTKlO3ueh4QPMrTIjw-1
X-Mimecast-MFC-AGG-ID: E4xdXTKlO3ueh4QPMrTIjw_1789062278
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9375d92d8cdso1365286685a.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789062278; x=1789667078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:references:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JT+A7W1MmDpVr6cMOdIJpFjVZmY1bGOG8YUIXDNF/Yo=;
        b=KG85I3IZNZ3vwavd7IFCxQ4KrhV5jqHBwHqn0BOcRrHaXlGr/23it85+P8Y+l1nlhV
         3Dsej6ycLcV/CILOgERUrxdpsmfhmg4gUGMMJBg0P0d0l7EtXuHKNvtKdH9qjbI62Vtq
         xngJrzVp2ZY4EvwBf9oyhZKF4aCp8H5QAivsncJVasz7B7Eq//CVDRTvU0ekteEhM6fN
         iX5QXl7nNKOTYYGChjxdgv0/7NbhOW3KfjlRlJ60jKnbPwOh+QHVZvGvYO9OP3LOtMjl
         7mdfiUiB1oGk4WpaMJUGTDIC8tzg5wzp7uFUWaWoV1E+qIu5nYRJCca448wALQQTsbT+
         f/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062278; x=1789667078;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JT+A7W1MmDpVr6cMOdIJpFjVZmY1bGOG8YUIXDNF/Yo=;
        b=WNZVvsMEUvqWIaRKDUvqyZ1Wg28go2otejrKuyizvN8YNg+cRBdV6QrJRsD/l7iW/r
         Np/NM1xYTmfb9AzGUPAIEaz9nlNulLLMrJw+LuX0kfbcUuggyMBQL0aR+0X6ekuzXenr
         KZPXv71egoVtLMroaUI+MK3KUFTh7lNVePxvkTAGRVnAx9rn5EDbRqqEQS/epJxBDdy0
         a5CdgtpYpIcgtV3mjX3oNZy5bAAN4+HzvsO2g8pnBoLEYcEX9rP1poBUIvy+pq99+60B
         EGRxLdrwd61ZRITPP5WrSncMoPTE9igZj2Neeuv4GploNfDF6iwRfBIqtABoc2slHbIy
         j97w==
X-Forwarded-Encrypted: i=1; AKwUvByGAdHggV6fpMWrtX/RRSsWfyccLzKoI6Qk2iVKun9wSRNg0U9bfmri5GObTrSB/0eO4gQvGPs=@vger.kernel.org
X-Gm-Message-State: AFuF++k7j/AQjqHB6dN0P7PqRSMLS6n5+PLJ2mMr/WlxVbLjW24VtoN/
	YZfli/4P1yZNQ/L7uvhTvoIBXJd5QM9bRMST9MJv/X28t8mgDDOGm59NFuonYbaAbIIO1fGi2gd
	DAt+Q2g+GWhQS+Osx46bReOB3X/6icAB+hz/bSCUpSRP+cRxJTfx6WfVyTA==
X-Gm-Gg: AYBFou0nKOqGRMnI59W4ihgAeysv+W/eylFtZu04GpFdTdHQs5lRANflIVmJ7CholBX
	KUemW7fXODfcmhPq2t0ZXQIsXPOq/8R4aUPk2w8MP+cmCUL5zQtdEGYyLv+V8V3r2WG5PDJnD7j
	XuhunnGwWLCAk7yZLFGHxRt5KzRT1FJJIsc7YkzqtZHIfeViRIW8WpfaMnAtDp2XvswwfvaI08v
	MfMQkztIOW1GcbFZaJTGHXbE//l7FWqqENmlUJvqfCArQu1A7MMmZOXdz6pdYx2kuir1kJcpaVT
	EHGUtczL97SEZ7cmVKBRpdqv73ANq93V8kamLuIKn52TS6KsAZxbL9Y7KopXiuaRnGN2eUE1vAl
	JDmaz0fmQ9remMwZXKVZ9sUJJWv5X
X-Received: by 2002:a05:620a:f0b:b0:939:a1cc:f234 with SMTP id af79cd13be357-939a1ccf31fmr3238070185a.5.1789062277525;
        Thu, 10 Sep 2026 10:44:37 -0700 (PDT)
X-Received: by 2002:a05:620a:f0b:b0:939:a1cc:f234 with SMTP id af79cd13be357-939a1ccf31fmr3238063185a.5.1789062276933;
        Thu, 10 Sep 2026 10:44:36 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80471a3sm34848885a.22.2026.09.10.10.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:44:36 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: netdev-bot+sashiko@kernel.org
Cc: houminxi@gmail.com,  netdev@vger.kernel.org,  echaudro@redhat.com,
  i.maximets@ovn.org,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  horms@kernel.org,
  shuah@kernel.org,  dev@openvswitch.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/4] selftests: openvswitch: add missing
 docstrings in ovs-dpctl.py
In-Reply-To: <178906092280.219967.16432524038911632507@kernel.org>
	(netdev-bot's message of "Thu, 10 Sep 2026 17:22:02 +0000")
References: <20260908171859.1967327-4-houminxi@gmail.com>
	<178906092280.219967.16432524038911632507@kernel.org>
Date: Thu, 10 Sep 2026 13:44:35 -0400
Message-ID: <f7t33vhm264.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> - [Low] The docstring added to print_ovsdp_full()
>   (tools/testing/selftests/net/openvswitch/ovs-dpctl.py line 2940)=E2=80=
=A6
>
> --
>
> selftests: openvswitch: add missing docstrings in ovs-dpctl.py
>
> This adds one-line docstrings to the module, classes and methods in the
> openvswitch selftest helper ovs-dpctl.py to silence pylint C0114, C0115
> and C0116. No code behaviour is changed.
>
>> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> index 502e6eb4c4b4..dc88cb1b20c1 100644
>> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>
> [ ... ]
>
>> @@ -2887,6 +2973,7 @@ class PsampleEvent(EventSocket):
>>=20=20
>>=20=20
>>  def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=3DNDB(), vpl=3DOvsVpor=
t()):
>> +    """Print full datapath state: stats, vports, and flows."""
>>  	  dp_name =3D dp_lookup_rep.get_attr("OVS_DP_ATTR_NAME")
>>  	  base_stats =3D dp_lookup_rep.get_attr("OVS_DP_ATTR_STATS")
>>  	  megaflow_stats =3D dp_lookup_rep.get_attr("OVS_DP_ATTR_MEGAFLOW_STAT=
S")
>
> [Severity: Low]
> Does print_ovsdp_full() actually print flows?  The body only emits the
> datapath name, the values from OVS_DP_ATTR_STATS,
> OVS_DP_ATTR_MEGAFLOW_STATS, OVS_DP_ATTR_MASKS_CACHE_SIZE and
> OVS_DP_ATTR_USER_FEATURES, then one line per vport:
>
>     print(f"  flows:{int(base_stats['flows'])}")
>     ...
>     # port print out
>     for iface in ndb.interfaces:
>         rep =3D vpl.info(iface.ifname, ifindex)
>         if rep is not None:
>             print(
>                 f"  port {int(rep.get_attr('OVS_VPORT_ATTR_PORT_NO'))}: "
>                 ...
>
> The only flow-related output is the flows:<n> counter that comes from
> OVS_DP_ATTR_STATS, which is already covered by "stats".
>
> Flow enumeration lives in OvsFlow.dump(), and main() calls that only for
> the dump subcommand, not on the show path that reaches
> print_ovsdp_full().
>
> Would something like "Print datapath statistics and attached vports." be
> a more accurate one-liner here?

I agree with this verbiage.

> The commit message says "Each docstring describes the command or
> attribute group the code actually implements", so this one looks like it
> overstates the output.

