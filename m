Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0623ABBF
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462679; cv=pass; b=DAbV+FT+l13LpHe57TmrK4upOns4UD8V+UkOh+3z4o75H3WwiOC6zj4tAVBlIK8DLTJR0HOWPi6V9rYmyi89psKzUK2Mq6QRa1r63f7IDkLV+HAvjLNlFnz/ziMe5BT7uC3Ybu0TIs4kFJqifT8aDpP792s2lyQaWF+S2pBrzek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462679; c=relaxed/simple;
	bh=0ql72QbH7pw4Axa3p8jt03Ns0TkORXMZdX5qHlPe2Lc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=u3sJkxm/kUJ58/opAvkZO6hhuplOULbTiloGDNbnalT9qSRLIh2PxyYcda0ZeiSfkm8VF3CLho82zvkD1l9svGW9C/A2qKo4NfbMtuyFR41P539FDC8CyAuc0PaD2YQxr2Y4g/C9DAIQbjtZdHadAq7041ezziejw0gOGzF7ORY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=afronta.com; spf=pass smtp.mailfrom=afronta.com; dkim=fail (0-bit key) header.d=afronta.com header.i=@afronta.com header.b=LHwuOIkP reason="key not found in DNS"; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=afronta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=afronta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=afronta.com header.i=@afronta.com header.b="LHwuOIkP"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530fa0716f6so28179721cf.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789462677; cv=none;
        d=google.com; s=arc-20260327;
        b=LYzu5mHf8QLKuJL9nBg9FwEttRxorVEzmczEY8gDpULOblfUnDFpmhDxycOs5AXeAU
         VbM3IaEMjOI19H5cP5MDz+LjlUaRW48Q/Kvu8fqJ/DjGS0lSreg97NOBuWcjnvc0nfRK
         fxm+mMdYG/0McTAh22SjG6f6ql3XPbthUhjidEg+fe/aI/iXw6f+Xb6qEqjjnp0/R1+m
         /C4HWyGc63naQ7KF5zzm/P0Suqk1jem+gmUe+H37uIq2YwYQ5pOeq2p1oz15phS439OF
         L+OVhmMH64r9MOQZuDYJyx/9Ok86rH16Y3YQfQ0IRYajoLZCWl0/OuF85reBKd/cMhe8
         MABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lhidRH+9Pkcz5W8FSzL02l8b5bot/SDbfN4RFTRjNFY=;
        fh=htAAq4qyVAT9WAomzgTyiF0PrXXDmKzdrYDaN2TpjPA=;
        b=IC0g6OhFawl29hbTP+QY/MGWp2wCJgi8cGCOKcfWqosSYZS+Nb7TeFUt574JAzxDWB
         NceoMVBR7HvRHCg1EsenTz1iMVYIVUO5w8i5Jl5KHtX45cy1W5ouMDpnOpt+Nf/eg1Ta
         lGREIGUnkacy/sLyedfq4WQ7oi8YRfAwC2PiQsi7/g9K0ZA5j1Ynz7hJXNNglvtN7R0F
         +uF8bPtzU68/2LXk7RpTpa2jgb9EUcl9k52CxI6YEfzx6rc7BAFGylhiUBcrQg0gySod
         /HJWxjFWygbJIhf6Btwef5NYSDiydr4NRqk8niougmaBD4i6OOGz5R9OFibc7BabBPdR
         o/Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=afronta.com; s=google; t=1789462677; x=1790067477; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lhidRH+9Pkcz5W8FSzL02l8b5bot/SDbfN4RFTRjNFY=;
        b=LHwuOIkPb1noDmNcLtCRbis8ATH679f9ZpNxJFbFEC0dQT51l9z1qX4hL4Dc4YqKh+
         IHTzoMFzBSPxwQfyKZ3ZHg+uJEexblC4twpQC5d3PixSmw1JPugfn78En2w8mwld9S90
         253hBV/pweOnqLgkNY8VGZWh7K+HJO05IpLxSC4THx2C5m3clfmrXMaDOe8hhIHaxMHY
         rPTmqXNmXg1m7SbLMcvbu9gH2wdAV06hZCz4fgjqpa7kaZSJhAJurWDCaYQsxrMidSSU
         7OwnVTD20Ea6y/tWjktU5zm2J0o4NE6w8XkVOZZdDe2rih/GVq3AKf0wDH16LzCdDv8r
         +4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789462677; x=1790067477;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lhidRH+9Pkcz5W8FSzL02l8b5bot/SDbfN4RFTRjNFY=;
        b=x9iZBDswZynDgoiHXUP0eGtlCu365PLepDa8v26+jUlz8cFVQiWl/xZy03zjQVAD/2
         Zv7fSiYwX7qTjKjst2CeFm9MOriP3H/XM2M0HQ+hf/Fy1pKklU9J1GZnXbV4V5vPpS4t
         /XIEudueBMWXFOY+EOoC3/mZRZrT/Mz+WTiDJh6takkLFYCA0ZYAg31Iz1xXFzh+jONb
         q2x+2edHBYwG9ptr992WUWk0DHQ8T6/E2wCAMisBylyNRM3bQXtSxUXkqPevvNLlQjKJ
         8b9Lml6LixfHQ2yP1F4uHI6h4CpmBjSEU2NQghyc9+1BdI3df2gmeG8VEkJUdjmvazzg
         js4A==
X-Forwarded-Encrypted: i=1; AKwUvBzBJc2IUoxNmy3CVnpI3QhnrzOMnsHs/WOSEJDuvQgot50dvzEb90sVy1fZlKPY8DbcnQcwrzY=@vger.kernel.org
X-Gm-Message-State: AFuF++nl2ddj4rOe+RXLdlYlbJEU1psFkwY04+wpLrpq/N82ksA2gNto
	1a6H2FoVtrr670JkfHT3tVixEoH34n0d13Q4KydfoqnJ16iO2gToMqxiH8kgPWgceHo6VtaDH5P
	6gaz1A3yt1EJUWwa15Zru7lpwUFeStJytiMh3Gwuo3p9sVbyfliKMoN8=
X-Gm-Gg: AYBFou3H4DiGcgIDE1d5SaRspAtpuFKi4OgOI5q4XqdLtBFTdtDEx1B459K0qdOK1cP
	Pf0mF/73ETZikaB/9JL4I0iaasV91KOzA7oxB0AA6NGU0VJNvehaANDJC886EDRzUmheNBIEi4f
	awulHmgBDV1pYqIcdO/JOa6tH6iCdkzsT6pW6P2y4mswuhILFtgJ1kCxprP3VFJXEWj/RBFhaSb
	SvCPS4PcoTGn909rixwMeWBpOjT9Wx3IYl/Dq9ILUEzHqz70TB3taFBAWydjptHmjsmYdheCzD6
	LQ0fU5ffXzzSV7w9A+2j4OvNhRJ7NyFviQYTEWnrWNPMEs0xnaY1T5nAO2TpPvo46CE+gxiesi3
	LJrDFwugbYw==
X-Received: by 2002:a05:622a:15c5:b0:530:f729:d7af with SMTP id
 d75a77b69052e-5310d093675mr86900221cf.54.1789462676763; Tue, 15 Sep 2026
 01:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Javier Herrera <javier.herrera@afronta.com>
Date: Tue, 15 Sep 2026 10:57:45 +0200
X-Gm-Features: AcwNN1Xje16APL8FB5kW-5dTK80nHClMRqtoCTZOipRNVUfKOw5E0o2_Qmwv9rs
Message-ID: <CAKRuCQLWEcci9hPgNUmvq44Bd2H30T5_vP=exMjsknXMN5Yh9A@mail.gmail.com>
Subject: [REGRESSION] e1000e: heavy packet loss on Lenovo ThinkPad P14s Gen 5
 (I219-LM, Meteor Lake) after K1 re-enable; fixed by disable-k1
To: intel-wired-lan@lists.osuosl.org
Cc: dima.ruinskiy@intel.com, vitaly.lifshits@intel.com, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	netdev@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

Since commit 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and
re-enable K1 on Meteor Lake") the integrated I219-LM in a Lenovo ThinkPad
P14s Gen 5 (Intel variant, Core Ultra 9 185H) shows constant packet loss
and erratic latency on the wired link. Wi-Fi and a USB-C RTL8152 adapter on
the same cable, switch and router are fine, so the network itself is not
the problem.

Setting the private flag "disable-k1" fixes it immediately, so this looks
like another system where the PLL clock gate reconfiguration is not enough
and the DMI quirk table introduced by that commit should be extended.

System
------
  Laptop:          Lenovo ThinkPad P14s Gen 5 (Intel)
  DMI sys_vendor:  LENOVO
  DMI product_name:    21G2CTO1WW
  DMI product_version: ThinkPad P14s Gen 5
  DMI board_name:  21G2CTO1WW
  BIOS:            R2DET43W (1.28), 2026-06-22
  CPU:             Intel(R) Core(TM) Ultra 9 185H (Meteor Lake)
  NIC:             00:1f.6 Ethernet Connection (18) I219-LM [8086:550a] (rev 20)
  dmesg:           MAC: 16, PHY: 12, PBA No: FFFFFF-0FF
  Kernel:          7.2.3-arch1-3 (Arch Linux)
  e1000e:          version 7.2.3-arch1-3, firmware-version 1.1-4
  Link:            1000 Mbps Full Duplex, Flow Control: Rx/Tx
  Link partner:    consumer GbE switch/router at 192.168.10.1

Reproduction
------------
Plug the cable and ping the default gateway on the LAN. No suspend/resume
involved, machine freshly booted and on AC power. Nothing e1000e-related in
dmesg apart from the link up/down messages; no "Hardware Unit Hang".

Default (K1 enabled):

  $ ping -c 30 192.168.10.1
  --- 192.168.10.1 ping statistics ---
  30 packets transmitted, 18 received, 40% packet loss, time 29734ms
  rtt min/avg/max/mdev = 0.211/0.315/0.384/0.046 ms

The lost packets are spread over the run (seq 6, 8, 9, 11, 13, 14, 16, 19,
20, 24, 25, 30), not a single burst. DHCP on this link also takes 1-2
minutes to get a lease, consistent with incoming packets being dropped.

With K1 disabled at runtime:

  # ethtool --set-priv-flags enp0s31f6 disable-k1 on
  $ ethtool --show-priv-flags enp0s31f6
  Private flags for enp0s31f6:
  s0ix-enabled: on
  disable-k1  : on

  $ ping -c 30 192.168.10.1
  --- 192.168.10.1 ping statistics ---
  30 packets transmitted, 30 received, 0% packet loss, time 29713ms
  rtt min/avg/max/mdev = 0.169/0.251/0.468/0.054 ms

  $ ping -c 30 192.168.10.1
  --- 192.168.10.1 ping statistics ---
  30 packets transmitted, 30 received, 0% packet loss, time 29677ms
  rtt min/avg/max/mdev = 0.101/0.222/0.360/0.064 ms

The result is stable across repeated runs and survives link down/up. I am
currently working around it with a udev rule that sets the flag on device
add.

Suggested change
----------------
Add the machine to disable_k1_list. Lenovo encodes the model in
DMI_PRODUCT_VERSION (product_name is the per-configuration machine type
21G2CTO1WW), so matching on that is more robust:

{
.ident = "Lenovo ThinkPad P14s Gen 5",
.matches = {
DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P14s Gen 5"),
},
},

Only the Intel variant (machine types 21G2/21G3) has an I219-LM, so the
match cannot hit the AMD version of the same model.

I am happy to test patches or collect more data (register dumps, ethtool
-S, different link partners) if useful.

#regzbot introduced: 578294b8b60d

Thanks,
Javier Herrera
