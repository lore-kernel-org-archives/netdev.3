Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98685265621
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 02:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787020695; cv=none; b=j1sYqV2UnG0zbUA0ejNtbJOBnz26zhs2jXRojtF7IVOHxG7boA2GqpgriG8eKvgTdduOeAj8ViYYlIF8k4kECNS/Y4cwT1tSd5WUQOvLCHU/BaUEvL0Oj2/eCVdDNXB6VnW7iEC6WPj/TaoOFvBYgzPd8eZTHp/runnxiu3KzpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787020695; c=relaxed/simple;
	bh=8Z51YQi+6F0VPvvZGknYxTCmnxgYxvGViWrlYhQcoKI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=fB1iUAATEsKuY7fscTubMbrRAIpLGllo/aZQL9/9O7PpyBheps7HacvVV5CV3QHZCM25LbQq6E5v6mdRKa5A2cMyFCzcBsYZ88hOUMvFTPukktw4SNtxlXE/wgu2yucuBY0Br/cz6TqUAjsc5V1ltflnWBAtOS1yoVZ4ysSYsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=0nwdvc7r; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="0nwdvc7r"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9aea40d799so2334795a12.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 19:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787020693; x=1787625493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J42WFQkv6WOJdJiC78RPvg8/4vZCvCj4eHcRotpw5KQ=;
        b=0nwdvc7rJBAkecgUXreYNYdOZEFEtoIMkf0e5gfFiwuISgZgIJAHRZHfEwtagSsK4i
         qQla6kax2QTGPocdUn4vX0qBkif+VS/C/ueyA1NdN1x+L+3A6eA70zYTyTYS1rdjvwf+
         rAYQlw6u/0Fma3/oNG+9hIO9473hBfY6/7X/zRDO2rWuknn6A2A/JjzvvROG49eJrkmo
         0NTUjEpRXeChvTFGqIlgLyRSjlLbjvMW7L9HJLala2jBx4aTh6GXi9J6bQcBCubWsYnJ
         i/9LgbDT8ISdybSxzlhnt5zb9JeRmHNZl2Fa9/X6tk6hS4JZbZ0FnUg7rXJiAnTiIQrs
         AH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787020693; x=1787625493;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J42WFQkv6WOJdJiC78RPvg8/4vZCvCj4eHcRotpw5KQ=;
        b=sjsy7WsIKACCS7P2ugUeE/DBPEOtjqlzQJ8bUiLEvcAPAHU8Lzdo5zRJHSELDur4kC
         7oN5iB1BffqylaEmC0DC6lBldn4kJhgMuvdiMEDEiJJZqog4fE6Js0SBCNGsb2tJu1Vp
         aqib7hOZ5ca0ZvqpNTW6ND9WxdEzrLO2gNoatvMp4+LduRbPV12WMu0zI/2SsBGgGQcT
         ohvcJYGMwjW2TQoS1sUYW0hhLKY8UiCpnQ3bTUtBH6khgnfGW5T+kkIdath+9CQIf4n7
         HV9dl8Xx1nLtVwk0u0fbS2lX+j46U/K0eG83c3Ls26JDuZjZbixcJyMojmOZGM5LAiUX
         dwaA==
X-Gm-Message-State: AOJu0YxWkjN2+dWtYvv5+0jtt6qPrOxLYfiBQJwCCo0KgUZjpBxZbD+m
	GpIoypoyl7CHm/iSyzc7unLmWjyrA9z+RJSvUHqekzlovx1hJB/N2fT+WLh0c/NaJK2HGrDNqpk
	cZ3Nv
X-Gm-Gg: AR+sD10Hh3U0fhPZc2rb/AlaW5qQ52pgqmF7OFH0jB2Ty12DwmmbPgptvj+Eqb7FFTk
	blJAuWwyGLRGn9/IboV47HMCG0Gp7hNWjIj33TUkYY/P45YvEBvIaAEetVjDceI8IuTPu6gPAOS
	2m/+AVdrMNLeu0K1sOHPbE1TW5z0n4cLDNtGdj7wAfv+pT8oksQ8c1aUkRSr2P0jmKkYwADSzM5
	O8iJ74IdmHLqhGh0kEVFQrxsiU8igr1BC1j7m2C3FiU2B0yFEO4YbG1uXUdTKJfzhAkQwFM+qEN
	ZZIbyG9bC04eXgWRvsFNL96lnc5Dwewj4KHwYKGOF5A+BRPtATnBZdk3MruiibByhAGXY0GCDHa
	hl8w35ZC1SdWwdhs4Yh5F+NKhr4O0cllBJeDg889J9KiGPwxDy+tSatPf1vC+r6cb1DHNjqgjme
	oPj+2vtUN7a108KfdslIsfglL0TzZ34rJ5GElaMcXcAy+hXwRFf0IhQIY9C8K/NXlD+LoHJZoVS
	cx9kj7XxtOvbKuwN9xTNd6vQEDKZw==
X-Received: by 2002:a05:6a21:a512:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3cc719f78admr30965567637.9.1787020692776;
        Mon, 17 Aug 2026 19:38:12 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1415315a206sm10293403c88.10.2026.08.17.19.38.11
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 19:38:12 -0700 (PDT)
Date: Mon, 17 Aug 2026 19:38:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: [ANNOUNCE] iproute2 7.2 release
Message-ID: <20260817193804.46fb3c18@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This is the regular release of iproute2 corresponding to the 7.2 kernel.

Highlights this cycle:
 * netshaper gained bw-min and weight parameters and group command for
   creating scheduling hierarchies
 * devlink resource show now supports dump, per-port resources and
   scope filtering
 * dpll added frequency monitoring and more pin attributes
 * ip and tc are faster on systems with many interfaces thanks to
   filtered link map dumps
 * network namespaces can be selected by pid
 * SECURITY file now documents the project threat model.
 * additional validate of time, rate an size parameters.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-7.2.0.tar.=
gz

Repository for current release:
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Andy Roulin (1):
      iplink: bridge: add stp_mode support

Asbj=C3=B8rn Sloth T=C3=B8nnesen (1):
      man/ip-ntable: fix app_probes typo

Danielle Ratson (3):
      bash-completion: devlink: Fix dev completion trailing colon
      iplink: bridge_slave: Add support for neigh_forward_grat
      bridge: vlan: Add support for neigh_forward_grat

David Ahern (7):
      Update kernel headers
      namespace: Add fallback to netns by pid
      iplink: Drop pid fallback code for netns
      rdma: Allow netns to be specified by pid
      devlink: Drop now duplicate pid fallback for netns
      Update kernel headers
      Update kernel headers

Eric Dumazet (5):
      ll_map: add RTEXT_FILTER_SKIP_STATS to ll_init_map()
      tc: use ll_init_map() only when needed
      tc: qdisc: provide tcm_handle and tcm_parent to kernel dump requests
      tc/class: use rtnl_dump_request_n() in tc_class_list()
      ll_map: add RTEXT_FILTER_NAME_ONLY to ll_link_get() and ll_init_map()

Fernando Fernandez Mancera (3):
      iplink: add support for setting IPv4 devconf parameters
      man: iplink: fix indentation level after inet parameter
      iplink: set NLA_F_NESTED for IPv4 devconf attributes

Ido Schimmel (2):
      devlink: Split dpipe tables output to a separate function
      devlink: Move dpipe tables query to resources show callback

Ivan Vecera (4):
      dpll: add ps unit to phase-related pin attributes
      dpll: add frequency monitoring support
      dpll: add pin operstate attribute support
      dpll: add fractional-frequency-offset to parent-device

Kuniyuki Iwashima (1):
      iplink_geneve: Support IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.

Mohsin Bashir (7):
      netshaper: Extract parse_scope() and parse_rate() helpers
      netshaper: Add bw-min and weight parameter support
      netshaper: Extend show output with parent, bw-min and weight
      netshaper: Extract struct shaper_args and parse_shaper_arg() helper
      netshaper: Add group command for creating scheduling hierarchies
      netshaper: Update man page for new parameters and group command
      netshaper: Fix man page accuracy and formatting issues

Or Har-Toov (5):
      devlink: fix memory leak in resource_ctx_fini
      devlink: add dump support for resource show
      devlink: show port resources in resource dump
      devlink: add per-port resource show support
      devlink: add scope filter to resource show

Petr Oros (2):
      dpll: man: restore Frequency monitor status in device show output
      dpll: monitor: add -t/--timestamp and --tshort options

Stephen Hemminger (12):
      man: remove libnetlink man page
      lib: add input validation for time, rate, and size parsing functions
      tc/netem: display per-impairment xstats counters
      uapi: update headers from 7.2-pre-rc1
      .mailmap: remove trailing whitespace
      CREDITS: remove trailing whitespace
      bridge: whitespace cleanup
      man: fix troff warnings and whitespace
      add print_hexstring helper
      ip: drop unnecessary fallback to ioctl for tx queue length
      SECURITY: add threat model
      v7.2.0

